#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
RUNTIME="$SKILL_DIR/.runtime"
UPSTREAM="$RUNTIME/upstream"
VENV="$RUNTIME/venv"
MARKER="$RUNTIME/.installed-commit"
EXPECTED_COMMIT="bff1011ef0ffc223680dabd3a1666574e4073ef0"
SOURCE_URL="https://github.com/hgayan7/autochrome.git"

if [[ -f "$MARKER" ]] && [[ "$(<"$MARKER")" == "$EXPECTED_COMMIT" ]]; then
  printf 'Pinned Autochrome already installed: %s\n' "$EXPECTED_COMMIT"
  exit 0
fi

if [[ -e "$RUNTIME" ]]; then
  printf 'Refusing to replace incomplete or unexpected runtime: %s\n' "$RUNTIME" >&2
  exit 1
fi

mkdir -p "$RUNTIME"
git init -q "$UPSTREAM"
git -C "$UPSTREAM" remote add origin "$SOURCE_URL"
git -C "$UPSTREAM" fetch -q --depth 1 origin "$EXPECTED_COMMIT"
git -C "$UPSTREAM" checkout -q --detach FETCH_HEAD

python3 - "$UPSTREAM/autochrome/preview/window.py" <<'PY'
from pathlib import Path
import sys

path = Path(sys.argv[1])
text = path.read_text(encoding="utf-8")
old = "from typing import Optional"
new = "from typing import Any, Optional"
if old not in text and new not in text:
    raise SystemExit(f"Compatibility patch target not found: {path}")
if old in text:
    path.write_text(text.replace(old, new, 1), encoding="utf-8")
PY

python3 -m venv "$VENV"
"$VENV/bin/python" -m pip install -q -e "$UPSTREAM"
printf '%s' "$EXPECTED_COMMIT" > "$MARKER"
printf 'Installed pinned Autochrome %s into %s\n' "$EXPECTED_COMMIT" "$RUNTIME"
