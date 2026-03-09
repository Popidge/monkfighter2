# Repository Workflow Notes

## Automatic Packaging

- CurseForge packaging is triggered by a GitHub webhook that targets this addon's CurseForge project.
- The CurseForge project is configured to package tagged commits only.
- `.pkgmeta` controls packaging behavior, including the manual changelog file used for release notes.

## Release Tag Convention

- Stable releases use `vMAJOR.MINOR.PATCH`, for example `v1.0.0`.
- Beta releases use `vMAJOR.MINOR.PATCH-beta.N`, for example `v1.0.1-beta.1`.
- Alpha releases use `vMAJOR.MINOR.PATCH-alpha.N`, for example `v1.0.1-alpha.1`.
- CurseForge detects `alpha` and `beta` in the tag name automatically and assigns the release type from the tag.

## Codex Release Flow

When the user asks to release this addon as `alpha`, `beta`, or `release`, follow this sequence:

1. If the worktree contains addon changes, commit that work first with a meaningful non-release commit message. The changelog is generated from commit subjects.
2. Run `python3 scripts/release.py <channel>` to generate `CHANGELOG.txt` and print the next tag.
3. Review the generated changelog. If the user asked for a custom release note, edit `CHANGELOG.txt` before committing.
4. Commit the release-ready changes, including `CHANGELOG.txt`, with a message like `release: <tag>`.
5. Create an annotated tag matching the suggested tag.
6. Push `main` and the new tag to `origin`.

## Changelog Notes

- CurseForge uses `CHANGELOG.txt` through `.pkgmeta` `manual-changelog`.
- `scripts/write_changelog.py` builds the changelog from commit subjects since the latest existing tag.
- `scripts/release.py` wraps changelog generation and tag suggestion so release turns stay short and consistent.

## WoW 12.x UI Notes

- On modern WoW 12.x clients, set a font on every `FontString` before calling `SetText()`. Creating a `FontString` and immediately calling `SetText()` without `SetFont()` can hard-error during addon load.
- `C_Spell.GetSpellTexture()` is strict on 12.x and can error on `nil` or invalid identifiers. Guard spell IDs before calling it, especially during addon load or preview states when no last combo spell exists yet.
- When restyling frames with dependent anchors, clear all points first and apply anchors in dependency-safe order. Switching between layouts can otherwise trigger `Cannot anchor to a region dependent on it` during reload or option changes.
