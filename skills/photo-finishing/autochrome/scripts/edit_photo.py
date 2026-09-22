#!/usr/bin/env python3
"""Conservative command-line wrapper around the pinned Autochrome engine."""

from __future__ import annotations

import argparse
import json
from pathlib import Path


def parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("input", type=Path)
    p.add_argument("output", type=Path)
    p.add_argument("--mode", choices=("smart", "master", "manual"), default="smart")
    p.add_argument("--mood", default="auto")
    for name in ("brightness", "contrast", "saturation", "ambiance", "highlights", "shadows", "warmth", "tint"):
        p.add_argument(f"--{name}", type=float)
    p.add_argument("--structure", type=float)
    p.add_argument("--sharpening", type=float)
    style = p.add_mutually_exclusive_group()
    style.add_argument("--film-stock")
    style.add_argument("--look")
    p.add_argument("--portrait", action="store_true")
    p.add_argument("--face-spotlight", type=float, default=12.0)
    p.add_argument("--skin-smoothing", type=float, default=12.0)
    p.add_argument("--eye-clarity", type=float, default=12.0)
    p.add_argument("--skin-warmth", type=float, default=3.0)
    p.add_argument("--crop", choices=("1:1", "16:9", "4:5", "9:16", "4:3", "3:2"))
    p.add_argument("--quality", type=int, default=95)
    return p


def main() -> None:
    args = parser().parse_args()
    source = args.input.expanduser().resolve()
    destination = args.output.expanduser().resolve()
    if not source.is_file():
        raise SystemExit(f"Input file not found: {source}")
    if source == destination:
        raise SystemExit("Input and output paths must be different")
    if not 1 <= args.quality <= 100:
        raise SystemExit("Quality must be between 1 and 100")

    from autochrome.mcp import tools

    destination.parent.mkdir(parents=True, exist_ok=True)
    opened = tools.tool_open_image(str(source), launch_preview=False)
    inspection = tools.tool_inspect_image()
    operations: list[dict] = []

    if args.mode == "smart":
        operations.append(tools.tool_smart_develop(target_mood=args.mood))
    elif args.mode == "master":
        operations.append(tools.tool_master_develop())

    tone_names = ("brightness", "contrast", "saturation", "ambiance", "highlights", "shadows", "warmth", "tint")
    tone = {name: getattr(args, name) for name in tone_names if getattr(args, name) is not None}
    if tone:
        operations.append(tools.tool_tune_image(**tone))
    if args.film_stock:
        operations.append(tools.tool_apply_film_stock(args.film_stock, protect_skin=True))
    if args.look:
        operations.append(tools.tool_apply_look(args.look))
    if args.portrait:
        operations.append(tools.tool_portrait_retouch(
            face_spotlight=args.face_spotlight,
            skin_smoothing=args.skin_smoothing,
            eye_clarity=args.eye_clarity,
            skin_tone_warmth=args.skin_warmth,
        ))
    if args.structure is not None or args.sharpening is not None:
        operations.append(tools.tool_adjust_details(
            structure=args.structure or 0.0,
            sharpening=args.sharpening or 0.0,
        ))
    if args.crop:
        operations.append(tools.tool_smart_crop(args.crop))

    suffix = destination.suffix.lower()
    formats = {".jpg": "JPEG", ".jpeg": "JPEG", ".png": "PNG", ".webp": "WEBP"}
    if suffix not in formats:
        raise SystemExit("Output extension must be .jpg, .jpeg, .png, or .webp")
    exported = tools.tool_export_image(str(destination), format=formats[suffix], quality=args.quality)
    print(json.dumps({
        "opened": opened,
        "inspection": inspection,
        "operations": operations,
        "exported": exported,
    }, ensure_ascii=False, indent=2, default=str))


if __name__ == "__main__":
    main()
