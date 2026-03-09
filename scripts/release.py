#!/usr/bin/env python3

from __future__ import annotations

import argparse
import re
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent
TAG_RE = re.compile(r"^v(\d+)\.(\d+)\.(\d+)(?:-(alpha|beta)\.(\d+))?$")


@dataclass(frozen=True, order=True)
class Version:
    major: int
    minor: int
    patch: int

    def __str__(self) -> str:
        return f"{self.major}.{self.minor}.{self.patch}"

    def next_patch(self) -> "Version":
        return Version(self.major, self.minor, self.patch + 1)


@dataclass(frozen=True)
class Tag:
    raw: str
    version: Version
    channel: str | None
    prerelease_number: int | None


def run_git(*args: str, check: bool = True) -> str:
    result = subprocess.run(
        ["git", *args],
        cwd=REPO_ROOT,
        text=True,
        capture_output=True,
        check=False,
    )
    if check and result.returncode != 0:
        raise RuntimeError(result.stderr.strip() or "git command failed")
    return result.stdout.strip()


def ensure_clean_worktree() -> None:
    status = run_git("status", "--short")
    if status:
        raise RuntimeError(
            "Working tree is not clean. Commit the addon changes first so the generated changelog includes them."
        )


def parse_tags() -> list[Tag]:
    output = run_git("tag", "--list")
    tags: list[Tag] = []
    for raw in output.splitlines():
        match = TAG_RE.match(raw.strip())
        if not match:
            continue
        major, minor, patch, channel, prerelease = match.groups()
        tags.append(
            Tag(
                raw=raw.strip(),
                version=Version(int(major), int(minor), int(patch)),
                channel=channel,
                prerelease_number=int(prerelease) if prerelease else None,
            )
        )
    return tags


def get_latest_stable(tags: list[Tag]) -> Version | None:
    stable_versions = [tag.version for tag in tags if tag.channel is None]
    return max(stable_versions) if stable_versions else None


def get_prereleases_for(tags: list[Tag], version: Version, channel: str) -> list[Tag]:
    return [tag for tag in tags if tag.version == version and tag.channel == channel]


def get_highest_prerelease_base(tags: list[Tag]) -> Version | None:
    prerelease_versions = [tag.version for tag in tags if tag.channel is not None]
    return max(prerelease_versions) if prerelease_versions else None


def next_prerelease_number(tags: list[Tag], version: Version, channel: str) -> int:
    existing = get_prereleases_for(tags, version, channel)
    if not existing:
        return 1
    return max((tag.prerelease_number or 0) for tag in existing) + 1


def suggest_tag(channel: str, explicit_version: str | None) -> str:
    if explicit_version:
        version = parse_version(explicit_version)
    else:
        tags = parse_tags()
        latest_stable = get_latest_stable(tags)
        if latest_stable is None:
            if channel == "release":
                version = Version(1, 0, 0)
            else:
                version = Version(1, 0, 0)
        elif channel == "release":
            prerelease_base = get_highest_prerelease_base(tags)
            version = prerelease_base if prerelease_base and prerelease_base > latest_stable else latest_stable.next_patch()
        else:
            prerelease_base = get_highest_prerelease_base(tags)
            if prerelease_base and prerelease_base > latest_stable:
                version = prerelease_base
            else:
                version = latest_stable.next_patch()

        if channel in {"alpha", "beta"}:
            next_number = next_prerelease_number(tags, version, channel)
            return f"v{version}-{channel}.{next_number}"

        return f"v{version}"

    if channel in {"alpha", "beta"}:
        tags = parse_tags()
        version_obj = parse_version(explicit_version)
        next_number = next_prerelease_number(tags, version_obj, channel)
        return f"v{explicit_version}-{channel}.{next_number}"

    return f"v{explicit_version}"


def parse_version(raw: str) -> Version:
    match = re.match(r"^(\d+)\.(\d+)\.(\d+)$", raw)
    if not match:
        raise ValueError(f"Invalid version '{raw}'. Expected MAJOR.MINOR.PATCH.")
    return Version(*(int(part) for part in match.groups()))


def main() -> int:
    parser = argparse.ArgumentParser(description="Suggest the next release tag and write CHANGELOG.txt.")
    parser.add_argument("channel", choices=["alpha", "beta", "release"])
    parser.add_argument("--version", help="Optional base version in MAJOR.MINOR.PATCH form.")
    args = parser.parse_args()

    ensure_clean_worktree()
    tag = suggest_tag(args.channel, args.version)
    subprocess.run(
        [sys.executable, str(REPO_ROOT / "scripts" / "write_changelog.py"), "--release-label", tag],
        cwd=REPO_ROOT,
        check=True,
    )
    print(tag)
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (RuntimeError, ValueError, subprocess.CalledProcessError) as exc:
        print(str(exc), file=sys.stderr)
        raise SystemExit(1)
