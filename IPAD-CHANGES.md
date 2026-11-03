# Beans Music iPad player

Based on the source corresponding to official v1.6.6. Version 1.6.6, build 100.

The Apple Music player style now automatically uses two columns on iPad windows
at least 700 points wide and 500 points high. The left pane contains artwork,
metadata, seek and transport controls. The right pane reuses the existing timed
lyrics, translations, tap-to-seek and manual scrolling with automatic resume.
Narrow iPad windows and iPhone retain the original single-column layout.

The app supports iPad natively, all four iPad orientations, and keeps iPhone
portrait behavior. Existing wallpapers, artwork blur, colors and playback
settings remain available. Tablet lyrics use the system bold font with Dynamic
Type scaling, faded edges and subdued inactive lines.

## Build

The dedicated `.github/workflows/build-ipad.yml` runs on pushes to
`codex/ipad-player`, or via workflow_dispatch on that branch. It compiles an
unsigned arm64 IPA using macOS 26/Xcode, validates the ZIP, device families,
orientations and encryption flags, and records SHA-256. The `Beans-iPad-IPA`
artifact contains `Beans-1.6.6-iPad.ipa`.

It also runs a deterministic, offline UI fixture in the Debug configuration on
an iPad Pro simulator, checking portrait and landscape placement and transport
button accessibility. Screenshots and build logs are in `iPad-layout-checks`.
The fixture is excluded from Release builds. Original CI/release workflows
are not triggered by this branch, and no release is published.

## Validation status

Local YAML parsing and `git diff --check` passed. macOS compilation and simulator
checks are pending GitHub write access. This archive is source code, not a built
or device-tested IPA. LiveContainer must sign/load the resulting unsigned IPA.

## Visual references

User-provided screenshot, plus:
https://support.apple.com/en-ae/guide/ipad/ipad7dff42c1/ipados
https://www.idownloadblog.com/2020/07/27/full-screen-lyrics-controls-music-ipad/
