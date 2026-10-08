#!/bin/bash
# Start Lab.command — macOS double-click launcher for the CTIA lab.
# Starts the local lab server (real bash terminal bridge) and opens the
# walkthrough in your default browser. No commands to type.
#
# Stop the lab: click this Terminal window, then press Ctrl+C.

cd "$(dirname "$0")" || exit 1

PY=""
for candidate in python3 python; do
  if command -v "$candidate" >/dev/null 2>&1; then PY="$candidate"; break; fi
done

if [ -z "$PY" ]; then
  echo "-------------------------------------------------------------"
  echo " Python 3 was not found on this Mac."
  echo " Install it from https://www.python.org/downloads/macos/"
  echo " then double-click this file again."
  echo "-------------------------------------------------------------"
  read -r -p "Press Enter to close this window. "
  exit 1
fi

echo "Starting CTIA Lab — unconstrained-delegation-001 ..."
echo "The browser will open automatically. Keep this window open."
echo
exec "$PY" serve.py --open