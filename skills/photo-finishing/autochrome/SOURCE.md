# Source and validation record

- Upstream: https://github.com/hgayan7/autochrome
- Pinned commit: `bff1011ef0ffc223680dabd3a1666574e4073ef0`
- Reviewed: 2026-09-22
- Upstream version: `1.0.0`
- Upstream license status: not verified

## Packaging decision

The upstream repository displays an MIT badge but contains no `LICENSE` file and no reliable license grant in the reviewed tree. This repository therefore does not redistribute the upstream source. The local installer fetches the exact public commit at setup time.

The local wrapper and scripts are repository-local work. They normalize triggering, protect source files, disable automatic preview windows in headless execution, expose a conservative CLI, and require visual review.

## Compatibility patch

The reviewed commit references `Any` in `autochrome/preview/window.py` without importing it. The installer changes:

```python
from typing import Optional
```

to:

```python
from typing import Any, Optional
```

No other upstream source modification is applied.

## Validation

- Code and dependency inspection completed.
- No credential collection or remote image upload was found in the core editing path.
- Preview mode opens a localhost HTTP/WebSocket service and may open a browser; the local wrapper runs headlessly by default.
- All 44 upstream tests passed after the one-line compatibility patch.
- A synthetic 960×640 photograph completed open, scene inspection, tone/color adjustment, detail adjustment, and JPEG export successfully.

## Known boundaries

- Raster photo finishing only; not a RAW demosaic engine.
- Automatic scene, face, crop, skin, and aesthetic analysis is heuristic.
- Output is a rendered image, not a reversible Lightroom-style edit history.
- Real user photos still require visual before/after inspection.
- Re-evaluate licensing before vendoring any upstream code.
