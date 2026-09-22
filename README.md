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
- Ghostty 1.3 or newer. With older versions the workflow falls back to sending ⌘N via
  System Events, which needs **Accessibility** permission for Alfred
  (System Settings → Privacy & Security)

## How it opens the window

Ghostty 1.3 added an [AppleScript dictionary](https://ghostty.org/docs/features/applescript).
The workflow creates a `surface configuration` with the project as working directory and
`claude` as initial input, then calls `new window with configuration`. No keystrokes, no
Accessibility permission. (Plain CLI launches like `open -na` or `ghostty -e` only give you
a tab of the running instance, which is why v1.1 still used ⌘N.)

## Install

Download the `.alfredworkflow` from [Releases](../../releases) and double-click it.

## AI disclosure

This workflow was built with the help of Claude Code (an LLM coding assistant).
I use it daily and reviewed and tested it myself.

## License

MIT
