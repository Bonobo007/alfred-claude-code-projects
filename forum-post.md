Title: Claude Code Projects — open a project folder in a new Ghostty window with Claude Code

Hi all,

I built a small workflow for starting Claude Code (Anthropic's coding CLI) in one of my project folders without clicking through Finder or typing `cd` paths.

**What it does**
Type `ccp` plus a few letters. It fuzzy-searches the top-level folders of your projects folder (folders with a `CLAUDE.md` or `.claude/` rank higher). Press ↩ and a new Ghostty window opens in that folder and runs `claude`.

- ↩ new Ghostty window + `claude`
- ⌥↩ `claude --continue` (resume last session)
- ⌃↩ just a terminal in that folder
- ⌘↩ reveal in Finder

Keyword and projects folder can be set in the workflow configuration.

**Why keystrokes**
On macOS, Ghostty turns every CLI launch (`open -na`, `ghostty -e …`) into a tab of the running instance and ignores `--working-directory` there. So the workflow activates Ghostty, sends ⌘N via System Events and types the command. That's why Alfred needs Accessibility permission. If anyone knows a cleaner way to get a real new Ghostty window, I'd love to hear it.

**Download / source**
https://github.com/Bonobo007/alfred-claude-code-projects/releases/latest

Feedback welcome!
