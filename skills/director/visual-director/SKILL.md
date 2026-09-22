---
name: visual-director
description: "Route image and photo requests through the right workflow in this repository. Use when a user supplies or describes a personal photo, product photo, portrait, lifestyle scene, travel image, food image, night photo, social graphic, wallpaper, or creative image task and needs the system to decide whether to preserve pixels, finish the photo, retouch, process RAW, apply a creative style, build a layout, or prepare final output."
---

# Visual Director

Treat this skill as a router and quality gate. Do not use it as a substitute for the downstream skill that performs the work.

## 1. Read the registry

Read `../../../registry/SKILLS.md` before choosing a downstream resource. Use only entries that exist and whose status allows routing. Never pretend that a proposed or missing capability is installed.

## 2. Classify the request

Determine:

- input: RAW/DNG, JPG/PNG/HEIC, generated image, or no image;
- scene: portrait, lifestyle, travel/landscape, food, product, architecture/street, night, document/design, or mixed;
- intent: faithful correction, retouch, creative reinterpretation, layout, restoration, or generation;
- output: normal photo, social post/story/reel cover, commercial asset, print, or wallpaper;
- preservation level: pixel-preserving, structure-preserving, or generative.

Ask one focused question only when a missing choice would materially change the result. Otherwise use the least destructive interpretation.

## 3. Choose the preservation level

Default to pixel-preserving adjustments for “修图、调色、出片、增强、变专业” unless the user requests reconstruction or style transformation.

- Pixel-preserving: exposure, white balance, tone, HSL, curves, sharpening, noise reduction, vignette, crop, and local masks.
- Structure-preserving: controlled cleanup, expansion, object removal, or limited reconstruction while retaining subject identity and geometry.
- Generative: posterization, collage, illustration, scene transformation, or other re-expression.

Disclose when a workflow will regenerate pixels rather than adjust the original photograph.

## 4. Route in this order

1. Protect source truth and scene logic.
2. Correct crop, lens/perspective, white balance, exposure, highlights, shadows, and tonal range.
3. Refine color relationships, HSL, curves, local contrast, detail, noise, and vignette.
4. Apply retouch only where needed and keep it natural by default.
5. Apply creative style only when requested or clearly implied.
6. Adapt composition, typography, logo, dimensions, and export for the final use.
7. Review the finished image at full frame and close detail.

Do not let a downstream style overwrite a sound base correction unless the requested aesthetic requires it.

## 5. Enforce visual logic

Every added form, color block, shadow, highlight, texture, plant, object, or typographic element must have a clear compositional or scene-based reason.

- Derive additions from visible subjects, surfaces, depth planes, light, motion, or the requested concept.
- Keep foreground, background, sky, ground, and occlusion relationships plausible.
- Do not place silhouettes or decorative motifs in spatially impossible locations.
- Avoid unexplained accent colors that neither balance the composition nor connect to source content.
- Prefer removal and simplification over decorative filling.
- Preserve faces, product identity, signage, architecture, and other semantic anchors unless the user explicitly requests change.

## 6. Route current resources

Use the registry’s current inventory:

- `morandi-cinematic-poster-zeejay` for source-faithful cinematic typography posters.
- `scenes-gathered-zine-v1-3` for deliberate torn-paper photo/illustration collage.
- GPT Image toolkits and prompt libraries for generation, prompt development, and reference exploration.

Do not route ordinary photo finishing into a poster or collage skill. Until a dedicated photo-finishing engine is registered, state the available execution method and keep edits conservative.

## 7. Quality gate

Before delivery, check:

- scene identity and spatial logic remain coherent;
- skin, food, product, sky, foliage, and neutrals are believable;
- highlights are not clipped unintentionally and shadows are not muddy;
- saturation and sharpening do not look brittle;
- crop and output ratio match the destination;
- text is accurate, readable, and inside safe areas;
- logo and brand assets are used only when relevant;
- no unrequested objects, symbols, or storytelling elements appeared.

If the result fails a check, revise before delivery.
