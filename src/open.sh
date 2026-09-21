#!/bin/bash
# Opens the selected project folder in a NEW Ghostty window and starts Claude Code.
# Same approach as the "In Ghostty öffnen" Quick Action: Cmd-N, then type the command.
dir="$1"
[ -d "$dir" ] || exit 1

case "${mode:-new}" in
  finder)
    open -R "$dir"
    exit 0
    ;;
  shell)
    cmd=""
    ;;
  continue)
    cmd=" && claude --continue"
    ;;
  *)
    cmd=" && claude"
    ;;
esac

osascript \
  -e 'on run argv' \
  -e 'set theDir to item 1 of argv' \
  -e 'set theCmd to item 2 of argv' \
  -e 'tell application "Ghostty" to activate' \
  -e 'delay 0.3' \
  -e 'tell application "System Events"' \
  -e 'keystroke "n" using command down' \
  -e 'delay 0.4' \
  -e 'keystroke "cd " & quoted form of theDir & theCmd' \
  -e 'key code 36' \
  -e 'end tell' \
  -e 'end run' \
  "$dir" "$cmd"
