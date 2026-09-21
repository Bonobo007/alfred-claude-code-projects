#!/usr/bin/env python3
"""Alfred Script Filter: fuzzy-search project folders, start Claude Code in them."""
import json
import os
import sys

ROOT = os.path.expanduser(os.environ.get("PROJECTS_DIR", "~/projects"))
CLAUDE_MARKERS = ("CLAUDE.md", ".claude")


def has(path, names):
    return any(os.path.exists(os.path.join(path, n)) for n in names)


def candidates():
    """Top-level folders of ROOT only — no subfolders."""
    items = []
    try:
        tops = sorted(os.scandir(ROOT), key=lambda e: e.name.lower())
    except OSError:
        return items
    for entry in tops:
        if not entry.is_dir() or entry.name.startswith("."):
            continue
        items.append((entry.name, entry.path))
    return items


def score(needle, haystack):
    """Subsequence fuzzy match. Returns (score, None) or (None, None) if no match."""
    if not needle:
        return 0
    n = needle.lower()
    h = haystack.lower()
    pos = 0
    total = 0
    streak = 0
    for ch in n:
        idx = h.find(ch, pos)
        if idx < 0:
            return None
        if idx == pos and pos > 0:
            streak += 1
            total += 10 + streak * 4          # consecutive characters
        else:
            streak = 0
            if idx == 0:
                total += 12                   # start of the name
            elif h[idx - 1] in "-_/ .":
                total += 9                    # start of a word
            else:
                total += 2
            total -= min(idx - pos, 6)        # penalty for skipped characters
        pos = idx + 1
    total -= len(h) * 0.08                    # slight preference for short names
    return total


def main():
    query = (sys.argv[1] if len(sys.argv) > 1 else "").strip()
    results = []
    for name, path in candidates():
        s = score(query, name)
        if s is None:
            continue
        is_claude = has(path, CLAUDE_MARKERS)
        if is_claude:
            s += 6
        results.append((s, name.lower(), name, path, is_claude))
    results.sort(key=lambda r: (-r[0], r[1]))

    items = []
    for _, _, name, path, is_claude in results[:30]:
        sub = path.replace(os.path.expanduser("~"), "~")
        items.append({
            "uid": path,
            "title": name,
            "subtitle": sub,
            "arg": path,
            "icon": {"type": "fileicon", "path": path},
            "variables": {"mode": "new"},
            "mods": {
                "alt": {
                    "subtitle": "Resume last session (claude --continue)",
                    "arg": path,
                    "variables": {"mode": "continue"},
                },
                "cmd": {
                    "subtitle": "Reveal in Finder",
                    "arg": path,
                    "variables": {"mode": "finder"},
                },
                "ctrl": {
                    "subtitle": "Open a terminal here (without Claude)",
                    "arg": path,
                    "variables": {"mode": "shell"},
                },
            },
        })

    if not items:
        items = [{
            "title": "No project found",
            "subtitle": "in %s" % ROOT.replace(os.path.expanduser("~"), "~"),
            "valid": False,
        }]
    sys.stdout.write(json.dumps({"items": items}))


if __name__ == "__main__":
    main()
