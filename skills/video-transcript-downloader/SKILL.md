---
name: video-transcript-downloader
description: Download and clean transcripts from YouTube and other yt-dlp-supported video URLs. Use when the user wants a video transcript, captions, subtitles, or plain-text notes extracted from a video without manually copying captions.
---

Extract a transcript with `yt-dlp`, then normalize the subtitle file into plain text.

Use this workflow:

1. Create a scratch directory for the transcript output.
2. Download subtitles only, not the video:

```powershell
New-Item -ItemType Directory -Force .tmp\video-transcript | Out-Null
py -m yt_dlp `
  --skip-download `
  --write-subs `
  --write-auto-subs `
  --sub-langs "en.*,en" `
  --convert-subs vtt `
  -o ".tmp/video-transcript/%(title)s.%(id)s.%(ext)s" `
  "<VIDEO_URL>"
```

3. Find the generated `.vtt` file.
4. Convert `.vtt` to plain text with `scripts/vtt_to_text.py`.
5. Read the `.txt` output and give the user the result or a concise summary, depending on the request.

Commands:

```powershell
Get-ChildItem .tmp\video-transcript -Filter *.vtt -Recurse
py .\skills\video-transcript-downloader\scripts\vtt_to_text.py "<INPUT.vtt>"
```

Notes:
- Prefer manual subtitles when present; `yt-dlp` will also fetch auto-generated subtitles when manual captions are missing.
- Keep the original `.vtt` alongside the cleaned `.txt` so timing can be recovered later if needed.
- If no English subtitles exist, inspect available subtitles first:

```powershell
py -m yt_dlp --list-subs "<VIDEO_URL>"
```

- If the user wants another language, change `--sub-langs`.
- If subtitle download fails because the site is unsupported or has no captions, say that directly and stop rather than fabricating a transcript.
