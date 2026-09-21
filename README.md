# Claude Code Projects — Alfred Workflow

Type `cc` plus a few letters, pick a project folder, and [Claude Code](https://claude.com/claude-code)
starts in a **new Ghostty window** inside that folder.

## Usage

`cc <letters>` fuzzy-searches the top-level folders of `~/projects`.
Folders that contain `CLAUDE.md` or `.claude/` rank higher.

| Key | Action |
|---|---|
| ↩ | New Ghostty window, `cd` into the folder, run `claude` |
| ⌥↩ | Same, but `claude --continue` (resume last session) |
| ⌃↩ | New Ghostty window in the folder, no Claude |
| ⌘↩ | Reveal the folder in Finder |

## Configuration

Workflow variable `PROJECTS_DIR` (default `~/projects`) sets the root folder.

## Requirements

- Alfred 5 with Powerpack
- [Ghostty](https://ghostty.org) and the `claude` CLI on your `PATH`
- Alfred needs **Accessibility** permission (System Settings → Privacy & Security),
  because the workflow opens the window via ⌘N and types the command

## Why keystrokes?

Ghostty on macOS turns every CLI launch (`open -na`, `ghostty -e …`) into a tab of the running
instance and ignores `--working-directory` there. Sending ⌘N via System Events is the only
reliable way to get a real new window.

## Install

Download the `.alfredworkflow` from [Releases](../../releases) and double-click it.

## License

MIT
