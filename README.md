# Claude Code Projects — Alfred Workflow

Type `ccp` (configurable) plus a few letters, pick a project folder, and [Claude Code](https://claude.com/claude-code)
starts in a **new Ghostty window** inside that folder.

## Usage

`ccp <letters>` fuzzy-searches the top-level folders of `~/projects`.
Folders that contain `CLAUDE.md` or `.claude/` rank higher.

| Key | Action |
|---|---|
| ↩ | New Ghostty window, `cd` into the folder, run `claude` |
| ⌥↩ | Same, but `claude --continue` (resume last session) |
| ⌃↩ | New Ghostty window in the folder, no Claude |
| ⌘↩ | Reveal the folder in Finder |

## Configuration

In the workflow configuration you can set the **keyword** (default `ccp`) and the **projects folder** (default `~/projects`).

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

## AI disclosure

This workflow was built with the help of Claude Code (an LLM coding assistant).
I use it daily and reviewed and tested it myself.

## License

MIT
