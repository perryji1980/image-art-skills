# Source and review record

- Upstream: https://github.com/majsterkovic/raw-photo-grade
- Pinned commit: `b5be2a18aa668128906598feb911177171606d5e`
- Upstream commit date: 2026-09-01
- Imported for review: 2026-09-22
- License: MIT
- Bundled archive SHA-256: `7f45c97e2385520fb6064a5f72b58534d839acdef31df2faef6b214d78bcaaf8`

## Packaging

The compressed archive preserves the upstream `phone-dng-grade`, `camera-raw-grade`, and `shared` folders without modification. `SKILL.md` and `scripts/install-upstream.sh` are local wrapper files; they are not upstream content.

The wrapper exists because the upstream skill frontmatter contains fields beyond `name` and `description`, and because several upstream capability claims require qualification before normal routing.

## Review results

- MIT license verified.
- No network requests, dynamic evaluation, shell execution, or credential handling were found in the Python engine.
- The only subprocess call invokes an optional local `exiftool` with a fixed argument list and `shell=False` behavior.
- Python syntax compilation passed for every script.
- `--help` passed for all eight phone/camera entry points.
- Global grade math passed a synthetic-array smoke test.
- Crop and before/after preview generation passed on an 800×600 synthetic image; the 4:5 output was 480×600.
- Full RAW decode was not run because `rawpy` and a representative RAW fixture were unavailable in the review environment.

## Verified limitations

- The save path converts processed output to 8-bit before JPEG or TIFF export.
- No code copies EXIF or other RAW metadata to the exported file.
- Output functions can replace an existing destination. The local wrapper therefore requires a distinct output path and preservation of the original.
- Automatic crop uses an attention heuristic and can cut people incorrectly.

Keep this package experimental until it has been tested on representative iPhone ProRAW and dedicated-camera RAW files and the resulting previews have been visually reviewed.
