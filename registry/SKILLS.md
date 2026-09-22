# Skill Registry

This is the routing map for the repository. Read it before selecting a skill, toolkit, or prompt library.

## Core rule

Finish the photograph before stylizing it:

1. Preserve source truth and visual logic.
2. Correct crop, perspective, white balance, exposure, and tonal range.
3. Refine color, detail, noise, and local emphasis.
4. Retouch only when needed.
5. Apply a creative style only when requested.
6. Build layout and export for the final destination.

A normal request to “修图、调色、出片、增强、变专业” must not be routed directly into a generative poster or collage workflow.

## Status meanings

| Status | Meaning |
|---|---|
| stable | Approved for normal routing |
| toolkit | Bundled capability; choose a specific internal skill or tool |
| reference | Source or prompt reference; not directly executable |
| experimental | Test before relying on it |
| proposed | Planned but not present |
| archived | Retained for history; exclude from normal routing |

## Current inventory

| Resource | Type | Category | Best for | Preservation | Status | Path |
|---|---|---|---|---|---|---|
| visual-director | router skill | director | Classifying image requests and selecting the workflow | N/A | stable | `skills/director/visual-director/` |
| morandi-cinematic-poster-zeejay | skill | creative-styles | Source-faithful cinematic photo posters driven by typography and negative space | Source photo locked; typography added | stable | `skills/movie-poster/` |
| scenes-gathered-zine-v1-3 | skill | creative-styles | Torn-paper photo/illustration zines with simplified abstract fields | Mixed photo preservation and generative illustration | stable | `skills/实景拼贴/` |
| autochrome-photo-finishing | skill | photo-finishing / photo-retouch | Everyday scene-aware correction, HSL, curves, natural portrait refinement, film looks, crop, and export | Deterministic pixel editing; original preserved | stable | `skills/photo-finishing/autochrome/` |
| raw-photo-grade-experimental | experimental wrapper skill | raw-workflow | iPhone ProRAW, phone DNG, and dedicated-camera RAW development with a preview loop | Pixel-preserving global RAW development; rendered 8-bit sRGB exports | experimental | `skills/experimental/raw-photo-grade/` |
| GPT-Image2-Skill | toolkit | generation/utilities | GPT Image generation, editing, prompt extraction, model guidance, and galleries | Depends on selected internal skill | toolkit | `toolkits/GPT-Image2-Skill/` |
| ai-image-prompts-skill | toolkit | prompt-discovery | Searching a large cross-model prompt library with examples | Generative reference | toolkit | `toolkits/ai-image-prompts-skill/` |
| awesome-gpt-image-2-freestylefly | toolkit | creative-styles/prompt-library | GPT Image style references, templates, design QA, and gallery material | Generative reference | toolkit | `toolkits/awesome-gpt-image-2-freestylefly/` |
| awesome-gpt-image-2-youmind | prompt library | prompt-library | Large GPT Image prompt and visual-reference gallery | Reference only | reference | `prompt-libraries/awesome-gpt-image-2-youmind/` |
| gpt4o-image-prompts | source reference | prompt-library | Chinese structured image prompts; upstream-only because no license was detected | Reference only | reference | `prompt-libraries/gpt4o-image-prompts/` |
| Awesome-AI-Images-Prompts | source reference | prompt-library | Cross-model Chinese prompt collection; upstream-only because no license was detected | Reference only | reference | `prompt-libraries/Awesome-AI-Images-Prompts/` |

## Routing notes

### Cinematic poster

Use `morandi-cinematic-poster-zeejay` only when the user wants a poster, cinematic title treatment, or film-key-art hierarchy. Do not use it for ordinary photo color correction.

### Gathered Scenes collage

Use `scenes-gathered-zine-v1-3` only when the user wants torn paper, zine, collage, abstract illustration, or a comparable creative transformation. Keep every added element spatially and conceptually connected to the source.

### Experimental RAW development

Use `raw-photo-grade-experimental` only when the user explicitly asks to test the experimental RAW workflow on a supported ProRAW, DNG, or camera RAW file. Do not route ordinary JPG, PNG, or HEIC editing here. Extract its pinned engine with the bundled installer, confirm `rawpy`/LibRaw availability, and visually inspect previews before any full-resolution export.

### Everyday photo finishing

Use `autochrome-photo-finishing` as the default for ordinary JPG, PNG, and WebP requests such as 修片、调色、增强、出片, natural portrait refinement, food/product color cleanup, travel/landscape finishing, and restrained film looks. Preserve the original, start conservatively, and visually inspect the rendered result before delivery.

### Toolkits and prompt libraries

Use a toolkit when its internal executable skill or script matches the task. Use prompt libraries to research directions and build prompts; do not describe a prompt library as an editing engine.

## Planned capability slots

These folders are reserved conceptually and should be created only when a real resource is admitted:

| Category | Intended scope |
|---|---|
| photo-finishing | Exposure, white balance, tone, HSL, curves, grading, sharpening, denoise, vignette |
| photo-retouch | Skin, eyes, hair, blemishes, cleanup, object removal, restrained local repair |
| raw-workflow | iPhone ProRAW/DNG and camera RAW development |
| commercial-product | Food, beverage, retail product, color accuracy, clean backgrounds, brand consistency |
| social-layout | Instagram posts/stories/reel covers, invitations, promotional layouts |
| wallpaper-output | Phone ratios, safe zones, 4K output, crop/extend/upscale |
| utilities | Background removal, resize, format conversion, logo application, batch work |

## Candidate queue

No candidates are currently queued.

## Adding or updating a resource

For every candidate:

1. Inspect code, dependencies, license, data handling, and whether it adjusts pixels or regenerates them.
2. Add it to `skills/experimental/` first unless it is a source-only reference.
3. Record the upstream repository, exact source revision when known, import date, license, local modifications, and status in `registry/sources.json`.
4. Test with representative portrait, lifestyle, food/product, landscape, and difficult low-light inputs as relevant.
5. Promote to the correct stable category only after the outputs and failure modes are understood.
6. Keep upstream code separate from local wrappers whenever practical.
7. Move replaced resources to `skills/archive/`; do not silently delete history.

## Updating this registry

Update this file and `registry/sources.json` in the same change whenever a resource is added, promoted, replaced, renamed, archived, or materially modified.
