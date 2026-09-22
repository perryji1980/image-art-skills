---
name: autochrome-photo-finishing
description: "Finish everyday JPG, PNG, and WebP photographs with deterministic pixel-preserving adjustments using a pinned Autochrome engine. Use when the user uploads a portrait, lifestyle, food, product, travel, landscape, street, architecture, or night photo and asks to 修片, 调色, 增强, 出片, improve it professionally, correct exposure or white balance, refine HSL and curves, retouch naturally, apply a restrained film look, crop, sharpen, or export a polished final image."
---

# Autochrome Photo Finishing

Use this as the default engine for ordinary photographic finishing. Do not route RAW/DNG files here; use the RAW workflow instead. Do not use it for generative reconstruction, poster design, or collage.

## Prepare the engine

Set `SKILL_DIR` to this folder. If `.runtime/.installed-commit` is absent, run:

```bash
bash "$SKILL_DIR/scripts/install-pinned.sh"
```

The installer downloads the reviewed upstream commit, applies the documented compatibility patch, and creates an isolated Python environment. Do not replace the pinned commit during a photo task.

## Finish a photo

1. Preserve the uploaded original and choose a distinct output path.
2. View the full image and identify subject, lighting, color cast, highlight/shadow risk, skin or product-color constraints, crop, noise, and destination.
3. Run a conservative first pass:

```bash
"$SKILL_DIR/.runtime/venv/bin/python" "$SKILL_DIR/scripts/edit_photo.py" \
  input.jpg output.jpg --mode smart --mood auto
```

4. View the result at full frame and close detail. Check skin, food, product color, sky, foliage, highlights, shadows, halos, sharpening, and crop.
5. If needed, rerun from the original with explicit adjustments rather than stacking repeated exports.
6. Deliver only after the result is visually coherent and the output dimensions and format are correct.

## Common controls

Use `--mode manual` for controlled correction. Available controls include:

- tone and color: `--brightness`, `--contrast`, `--saturation`, `--ambiance`, `--highlights`, `--shadows`, `--warmth`, `--tint`;
- detail: `--structure`, `--sharpening`;
- style: one of `--film-stock` or `--look`;
- portrait: `--portrait`, with optional `--skin-smoothing`, `--eye-clarity`, `--face-spotlight`, and `--skin-warmth`;
- framing: `--crop 1:1|16:9|4:5|9:16|4:3|3:2`.

Run `edit_photo.py --help` for the complete interface.

## Guardrails

- Keep the input and output paths different.
- Default to subtle correction; do not apply a film stock unless requested or clearly beneficial.
- Keep skin texture natural. Avoid high smoothing and brittle eye sharpening.
- Do not use smart crop without checking faces, limbs, products, signage, and negative space.
- Do not claim true RAW development, lens profiles, catalog integration, or reversible Lightroom edits.
- Treat automatic scene classification and aesthetic scores as heuristics, not ground truth.
- Autochrome edits pixels deterministically; it does not generate a replacement scene.

Read `SOURCE.md` before updating the pinned engine.
