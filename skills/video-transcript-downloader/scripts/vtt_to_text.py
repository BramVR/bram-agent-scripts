#!/usr/bin/env python3
import argparse
import html
import re
import sys
from pathlib import Path


TIMESTAMP_RE = re.compile(
    r"^\d{2}:\d{2}:\d{2}\.\d{3}\s+-->\s+\d{2}:\d{2}:\d{2}\.\d{3}"
    r"|^\d{2}:\d{2}\.\d{3}\s+-->\s+\d{2}:\d{2}\.\d{3}$"
)
TAG_RE = re.compile(r"<[^>]+>")


def clean_caption_line(line: str) -> str:
    line = TAG_RE.sub("", line)
    line = html.unescape(line)
    line = re.sub(r"\s+", " ", line).strip()
    return line


def vtt_to_lines(text: str) -> list[str]:
    lines: list[str] = []
    previous = None

    for raw in text.splitlines():
        line = raw.strip("\ufeff").strip()
        if not line:
            continue
        if line == "WEBVTT":
            continue
        if line.startswith(("NOTE", "STYLE", "REGION")):
            continue
        if TIMESTAMP_RE.match(line):
            continue
        if line.isdigit():
            continue

        line = clean_caption_line(line)
        if not line:
            continue
        if line == previous:
            continue

        lines.append(line)
        previous = line

    return lines


def main() -> int:
    parser = argparse.ArgumentParser(description="Convert a WebVTT subtitle file to plain text.")
    parser.add_argument("input", help="Path to the .vtt file")
    parser.add_argument(
        "-o",
        "--output",
        help="Output .txt path. Defaults to the input path with a .txt suffix.",
    )
    args = parser.parse_args()

    input_path = Path(args.input)
    if not input_path.is_file():
        raise SystemExit(f"Input file not found: {input_path}")

    output_path = Path(args.output) if args.output else input_path.with_suffix(".txt")
    text = input_path.read_text(encoding="utf-8")
    lines = vtt_to_lines(text)
    output_path.write_text("\n".join(lines) + "\n", encoding="utf-8")

    try:
        print(output_path)
    except UnicodeEncodeError:
        sys.stdout.buffer.write((str(output_path) + "\n").encode("utf-8", errors="replace"))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
