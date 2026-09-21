# alfred-claude-code-projects

Alfred-Workflow „Claude Code Projects“ (Stichwort bei Kirill `cc`, Standard `ccp`): Projektordner fuzzy suchen → neues
Ghostty-Fenster + `claude`. Nutzer-Doku: README.md (englisch, für GitHub).

## Aufbau
- `src/` = der Workflow selbst. **Der installierte Workflow ist ein Symlink hierauf**
  (`~/Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/user.workflow.2AFE9E1F-…`),
  Änderungen in `src/` wirken sofort in Alfred. In Alfred bearbeiten schreibt ebenfalls hierher.
- `src/filter.py` = Script Filter, `src/open.sh` = Aktion (osascript ⌘N + tippen), `src/info.plist` = Verdrahtung.
- `./build.sh` → `dist/Claude Code Projects-<version>.alfredworkflow` (dist/ ist nicht in git; Release-Asset).

## Fallen
- Ghostty: jeder CLI-Start wird zum Tab; nur System Events → ⌘N ergibt ein neues Fenster.
- Script Filter `argumenttype` muss 0 (Argument erforderlich) bleiben, sonst mischt Alfred eigene Treffer unter.
- `src/prefs.plist` = Kirills lokale Konfig (keyword=cc); gitignored, build.sh packt sie nicht ein.

## Release
Version in `src/info.plist` hochzählen → `./build.sh` → `gh release create v<version> dist/*.alfredworkflow`.
