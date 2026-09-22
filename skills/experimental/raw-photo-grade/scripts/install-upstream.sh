#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ARCHIVE="$SKILL_DIR/upstream-b5be2a18.tar.gz"
DEST="$SKILL_DIR/upstream"
EXPECTED_SHA="7f45c97e2385520fb6064a5f72b58534d839acdef31df2faef6b214d78bcaaf8"
EXPECTED_COMMIT="b5be2a18aa668128906598feb911177171606d5e"

if [[ -f "$DEST/.source-commit" ]] && [[ "$(<"$DEST/.source-commit")" == "$EXPECTED_COMMIT" ]]; then
  printf 'Pinned upstream already installed: %s\n' "$EXPECTED_COMMIT"
  exit 0
fi

if [[ -e "$DEST" ]]; then
  printf 'Refusing to replace existing directory: %s\n' "$DEST" >&2
  exit 1
fi

if [[ ! -f "$ARCHIVE" ]]; then
  printf 'Missing bundled archive: %s\n' "$ARCHIVE" >&2
  exit 1
fi

ACTUAL_SHA="$(sha256sum "$ARCHIVE" | awk '{print $1}')"
if [[ "$ACTUAL_SHA" != "$EXPECTED_SHA" ]]; then
  printf 'Archive checksum mismatch. Expected %s, got %s\n' "$EXPECTED_SHA" "$ACTUAL_SHA" >&2
  exit 1
fi

mkdir "$DEST"
tar -xzf "$ARCHIVE" -C "$DEST"

for required in \
  "$DEST/phone-dng-grade/SKILL.md" \
  "$DEST/camera-raw-grade/SKILL.md" \
  "$DEST/shared/scripts/raw_develop.py"; do
  if [[ ! -f "$required" ]]; then
    printf 'Incomplete upstream archive; missing %s\n' "$required" >&2
    exit 1
  fi
done

printf '%s' "$EXPECTED_COMMIT" > "$DEST/.source-commit"
printf 'Installed pinned upstream %s into %s\n' "$EXPECTED_COMMIT" "$DEST"
