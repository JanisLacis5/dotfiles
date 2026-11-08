#!/usr/bin/env python3
"""Copy a piped message's ID, or report the copied ID for NeoMutt's echo."""

import subprocess
import sys
from email.parser import BytesHeaderParser


if sys.argv[1:] == ["--show"]:
    result = subprocess.run(
        ["xclip", "-selection", "clipboard", "-o"],
        capture_output=True, text=True,
    )
    message_id = result.stdout.strip()
    if result.returncode:
        print("Could not read the clipboard")
    else:
        print(f"Message-ID (copied): {message_id}" if message_id else "No Message-ID header")
else:
    headers = BytesHeaderParser().parse(sys.stdin.buffer)
    message_id = " ".join(str(headers.get("Message-ID", "")).split())
    if message_id.startswith("<") and message_id.endswith(">"):
        message_id = message_id[1:-1]
    subprocess.run(
        ["xclip", "-selection", "clipboard"],
        input=message_id.encode(), check=True,
    )
