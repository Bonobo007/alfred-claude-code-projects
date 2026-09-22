#!/bin/bash
# Opens the selected project folder in a NEW Ghostty window and starts Claude Code.
#
# Ghostty >= 1.3 has an AppleScript dictionary: "new window with configuration"
# takes a working directory and an initial input, so no keystrokes and no
# Accessibility permission are needed. Older Ghostty falls back to the
# System Events route (activate, Cmd-N, type the command).
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
    cmd="claude --continue"
    ;;
  *)
    cmd="claude"
    ;;
esac

# Preferred: Ghostty AppleScript (1.3+)
if osascript \
  -e 'on run argv' \
  -e 'set theDir to item 1 of argv' \
  -e 'set theCmd to item 2 of argv' \
  -e 'tell application "Ghostty"' \
  -e 'set cfg to new surface configuration' \
  -e 'set initial working directory of cfg to theDir' \
  -e 'if theCmd is not "" then set initial input of cfg to theCmd & linefeed' \
  -e 'set w to new window with configuration cfg' \
  -e 'activate' \
  -e 'activate window w' \
  -e 'end tell' \
  -e 'end run' \
  "$dir" "$cmd" 2>/dev/null; then
  exit 0
fi

# Fallback for Ghostty < 1.3: needs Accessibility permission for Alfred.
[ -n "$cmd" ] && cmd=" && $cmd"
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
