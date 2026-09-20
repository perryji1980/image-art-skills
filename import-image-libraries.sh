#!/usr/bin/env bash
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

mkdir -p toolkits
mkdir -p prompt-libraries

copy_selected () {
  REPO="$1"
  KEY="$2"
  DEST="$3"
  shift 3

  SRC="$TMP/$KEY"

  echo
  echo "===================================="
  echo "Importing $REPO"
  echo "===================================="

  git clone \
    --depth=1 \
    --filter=blob:none \
    --no-checkout \
    "https://github.com/$REPO.git" \
    "$SRC"

  for PATH_TO_COPY in "$@"; do
    if git -C "$SRC" cat-file -e "HEAD:$PATH_TO_COPY" 2>/dev/null; then
      echo "  + $PATH_TO_COPY"
      git -C "$SRC" checkout HEAD -- "$PATH_TO_COPY"
    else
      echo "  - skipping missing: $PATH_TO_COPY"
    fi
  done

  rm -rf "$DEST"
  mkdir -p "$DEST"

  (
    cd "$SRC"
    tar --exclude=.git -cf - .
  ) | (
    cd "$DEST"
    tar -xf -
  )
}


# =========================================================
# 1/6 freestylefly/awesome-gpt-image-2
# Industrial prompt templates + Agent Skill
# =========================================================

copy_selected \
  "freestylefly/awesome-gpt-image-2" \
  "freestylefly-awesome-gpt-image-2" \
  "toolkits/awesome-gpt-image-2-freestylefly" \
  "README.md" \
  "README.zh-CN.md" \
  "LICENSE" \
  "design-qa.md" \
  "agents/skills/gpt-image-2-style-library" \
  "docs/templates.md" \
  "docs/gallery.md" \
  "docs/gallery-part-1.md" \
  "docs/gallery-part-2.md"

cat > toolkits/awesome-gpt-image-2-freestylefly/SOURCE.md <<'EOF'
# Source

Original repository:
https://github.com/freestylefly/awesome-gpt-image-2

Purpose:
Industrial GPT Image prompt templates, style library, and Agent Skill.

License:
MIT License. See LICENSE in this folder.

This is a curated local copy of the useful prompt/skill components.
EOF


# =========================================================
# 3/6 YouMind-OpenLab/awesome-gpt-image-2
# Large GPT Image prompt gallery
# =========================================================

copy_selected \
  "YouMind-OpenLab/awesome-gpt-image-2" \
  "youmind-awesome-gpt-image-2" \
  "prompt-libraries/awesome-gpt-image-2-youmind" \
  "README.md" \
  "README_zh.md" \
  "LICENSE"

cat > prompt-libraries/awesome-gpt-image-2-youmind/SOURCE.md <<'EOF'
# Source

Original repository:
https://github.com/YouMind-OpenLab/awesome-gpt-image-2

Purpose:
Large GPT Image prompt and visual-reference gallery.

License:
CC BY 4.0. See LICENSE in this folder.

Attribution to YouMind OpenLab must be preserved.
EOF


# =========================================================
# 5/6 YouMind-OpenLab/ai-image-prompts-skill
# 10,000+ searchable prompt Agent Skill
# =========================================================

copy_selected \
  "YouMind-OpenLab/ai-image-prompts-skill" \
  "ai-image-prompts-skill" \
  "toolkits/ai-image-prompts-skill" \
  "README.md" \
  "SKILL.md" \
  "LICENSE" \
  "_meta.json" \
  "package.json" \
  "pnpm-lock.yaml" \
  "tsconfig.json" \
  "scripts" \
  "references"

cat > toolkits/ai-image-prompts-skill/SOURCE.md <<'EOF'
# Source

Original repository:
https://github.com/YouMind-OpenLab/ai-image-prompts-skill

Purpose:
Searchable Agent Skill backed by a large cross-model image prompt library.

License:
MIT License. See LICENSE in this folder.
EOF


# =========================================================
# 4/6 songguoxs/gpt4o-image-prompts
# No LICENSE currently detected — keep source reference only
# =========================================================

mkdir -p prompt-libraries/gpt4o-image-prompts

cat > prompt-libraries/gpt4o-image-prompts/SOURCE.md <<'EOF'
# GPT4o Image Prompts

Original repository:
https://github.com/songguoxs/gpt4o-image-prompts

Purpose:
Chinese image prompts and structured prompts.json dataset.

Note:
No LICENSE file was detected in the upstream repository when this
collection entry was created, so the upstream contents are not
redistributed here.

Use the original repository as the source.
EOF


# =========================================================
# 6/6 dongyubin/Awesome-AI-Images-Prompts
# No LICENSE currently detected — keep source reference only
# =========================================================

mkdir -p prompt-libraries/Awesome-AI-Images-Prompts

cat > prompt-libraries/Awesome-AI-Images-Prompts/SOURCE.md <<'EOF'
# Awesome AI Images Prompts

Original repository:
https://github.com/dongyubin/Awesome-AI-Images-Prompts

Purpose:
Cross-model Chinese image prompt collection covering GPT Image,
Nano Banana, Seedream, Flux, and other image models.

Note:
No LICENSE file was detected in the upstream repository when this
collection entry was created, so the upstream contents are not
redistributed here.

Use the original repository as the source.
EOF


echo
echo "===================================="
echo "Saving to image-art-skills"
echo "===================================="

git add import-image-libraries.sh toolkits prompt-libraries

if git diff --cached --quiet; then
  echo "No new changes to commit."
else
  git commit -m "Add image prompt libraries and agent skills"
  git push
fi

echo
echo "===================================="
echo "DONE"
echo "===================================="
echo
echo "Imported:"
echo "  ✓ freestylefly awesome-gpt-image-2"
echo "  ✓ YouMind awesome-gpt-image-2"
echo "  ✓ YouMind ai-image-prompts-skill"
echo "  ↗ songguoxs gpt4o-image-prompts source reference"
echo "  ↗ dongyubin Awesome-AI-Images-Prompts source reference"
echo "  ✓ Existing GPT-Image2-Skill left untouched"