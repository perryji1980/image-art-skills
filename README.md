# image-art-skills

A modular personal visual-workbench repository for photo finishing, retouching, RAW workflows, commercial imagery, creative styles, social layouts, wallpapers, and reusable image tools.

## Start here

- [Skill registry](registry/SKILLS.md) — what each resource does and when to use it
- [Source tracking](registry/sources.json) — upstream repositories, licenses, and update state
- [Visual Director](skills/director/visual-director/SKILL.md) — routes a request through the right workflow

## Repository layers

- `skills/` — callable visual workflows
- `toolkits/` — larger tools or bundled skill collections
- `prompt-libraries/` — prompt and visual-reference collections
- `registry/` — inventory and upstream tracking

Existing resources remain in place during the staged reorganization. New candidates enter `skills/experimental/` first; retired resources move to `skills/archive/` instead of being silently deleted.
