---
name: raw-photo-grade-experimental
description: "Experimentally develop and grade iPhone ProRAW, phone DNG, and DSLR or mirrorless RAW files using a pinned local copy of raw-photo-grade. Use only when the user explicitly asks to test the experimental RAW workflow for DNG, ProRAW, NEF, CR2, CR3, ARW, RAF, ORF, RW2, PEF, SRW, or similar camera RAW files."
---

# RAW Photo Grade — Experimental

Use this wrapper only for deliberate testing. Do not route ordinary JPG, PNG, or HEIC editing here.

## Prepare the pinned engine

Set `SKILL_DIR` to this folder. If `upstream/.source-commit` is absent, run:

```bash
bash "$SKILL_DIR/scripts/install-upstream.sh"
```

This extracts the reviewed upstream snapshot bundled with the skill. Do not replace it with the current upstream default branch during a photo task.

The engine requires Python 3.10+, `rawpy>=0.21`, `numpy>=1.24`, `Pillow>=10`, and LibRaw. Install dependencies only when the user authorizes environment changes.

## Choose the correct path

- Use `upstream/phone-dng-grade/` for iPhone ProRAW, Pixel RAW+, Samsung Expert RAW, and other computational phone DNG files.
- Use `upstream/camera-raw-grade/` for dedicated-camera NEF, CR2/CR3, ARW, RAF, ORF, RW2, PEF, SRW, and DNG files.

Do not treat a phone DNG like a conventional camera RAW. Phone files may already contain computational tone mapping and need gentler shadow, clarity, and sharpening moves.

## Work in a preview loop

1. Inspect metadata and RAW dimensions.
2. Create a neutral 1600-pixel preview.
3. View the preview and describe visible exposure, white balance, highlight, shadow, noise, crop, and subject issues.
4. Apply a named look only as a starting point, then override the necessary sliders.
5. Regenerate and inspect the preview after every meaningful change.
6. Crop after the grade is understood; never trust the subject heuristic around faces or limbs without visual inspection.
7. Export full resolution only after the preview passes review.

Example for iPhone ProRAW:

```bash
python3 "$SKILL_DIR/upstream/phone-dng-grade/scripts/inspect_dng.py" photo.dng
python3 "$SKILL_DIR/upstream/phone-dng-grade/scripts/develop.py" photo.dng \
  -o edited/photo-preview.jpg --look neutral --preview
```

Example for a camera RAW:

```bash
python3 "$SKILL_DIR/upstream/camera-raw-grade/scripts/inspect_raw.py" photo.nef
python3 "$SKILL_DIR/upstream/camera-raw-grade/scripts/develop.py" photo.nef \
  -o edited/photo-preview.jpg --look neutral --preview
```

## Protect the source

- Never pass the input RAW path as the output path.
- Write outputs to a separate `edited/` folder or an explicit new filename.
- Verify the resolved input and output paths differ before execution.
- Preserve the original RAW even when an edit fails.
- Avoid batch full-resolution export until representative previews have been checked.

## Know the current limitations

- The engine performs global adjustments; it does not provide local masks, object retouching, HSL channels, lens profiles, or Lightroom-compatible parametric edits.
- JPEG and TIFF outputs are currently 8-bit sRGB.
- The engine does not copy RAW metadata into exports despite the upstream documentation's metadata-preservation claim.
- Named looks are fixed starting recipes, not automatic scene analysis.
- Automatic subject crop is a contrast/saturation/center heuristic and is not face-aware.
- Real RAW decode cannot be validated without `rawpy`, LibRaw, and an actual supported RAW file.

Read `SOURCE.md` before modifying or updating the pinned upstream snapshot.
