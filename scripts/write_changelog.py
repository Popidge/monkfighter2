#!/usr/bin/env python3

from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent
DEFAULT_OUTPUT = REPO_ROOT / "CHANGELOG.txt"


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


def get_latest_tag() -> str | None:
    tag = run_git("describe", "--tags", "--abbrev=0", check=False)
    return tag or None


def get_commit_subjects(start_ref: str | None, end_ref: str) -> list[str]:
    revision_range = f"{start_ref}..{end_ref}" if start_ref else end_ref
    output = run_git("log", revision_range, "--pretty=format:%s")
    subjects = [line.strip() for line in output.splitlines() if line.strip()]
    return subjects


def render_changelog(base_ref: str | None, target_ref: str, release_label: str | None) -> str:
    header = f"Release: {release_label}" if release_label else "Unreleased"
    compared_from = base_ref or "initial commit"
    lines = [
        header,
        f"Changes since {compared_from}:",
        "",
    ]

    subjects = get_commit_subjects(base_ref, target_ref)
    if subjects:
        for subject in subjects:
            lines.append(f"- {subject}")
    else:
        lines.append("- No code changes since the previous release.")

    lines.append("")
    return "\n".join(lines)


def main() -> int:
    parser = argparse.ArgumentParser(description="Generate CurseForge changelog text from git history.")
    parser.add_argument("--from-ref", dest="from_ref", help="Start ref for changelog generation.")
    parser.add_argument("--to-ref", default="HEAD", help="End ref for changelog generation. Defaults to HEAD.")
    parser.add_argument("--release-label", help="Optional release label to print in the changelog header.")
    parser.add_argument(
        "--output",
        default=str(DEFAULT_OUTPUT),
        help="Where to write the changelog. Defaults to CHANGELOG.txt in the repo root.",
    )
    args = parser.parse_args()

    from_ref = args.from_ref or get_latest_tag()
    content = render_changelog(from_ref, args.to_ref, args.release_label)
    output_path = Path(args.output)
    output_path.write_text(content, encoding="utf-8")
    print(f"Wrote changelog to {output_path.relative_to(REPO_ROOT)}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except RuntimeError as exc:
        print(str(exc), file=sys.stderr)
        raise SystemExit(1)
