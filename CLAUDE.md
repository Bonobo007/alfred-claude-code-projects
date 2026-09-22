# alfred-claude-code-projects

Alfred-Workflow „Claude Code Projects“ (Stichwort bei Kirill `cc`, Standard `ccp`): Projektordner fuzzy suchen → neues
Ghostty-Fenster + `claude`. Nutzer-Doku: README.md (englisch, für GitHub).

## Aufbau
- `src/` = der Workflow selbst. **Der installierte Workflow ist ein Symlink hierauf**
  (`~/Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/user.workflow.2AFE9E1F-…`),
  Änderungen in `src/` wirken sofort in Alfred. In Alfred bearbeiten schreibt ebenfalls hierher.
- `src/filter.py` = Script Filter, `src/open.sh` = Aktion (Ghostty-AppleScript `new window with configuration`, Fallback ⌘N + tippen), `src/info.plist` = Verdrahtung.
- `./build.sh` → `dist/Claude Code Projects-<version>.alfredworkflow` (dist/ ist nicht in git; Release-Asset).

## Fallen
- Ghostty: jeder CLI-Start wird zum Tab. Seit Ghostty 1.3 gibt es AppleScript (`new surface configuration` mit
  `initial working directory` + `initial input`, dann `new window with configuration`); darunter nur System Events → ⌘N.
- Script Filter `argumenttype` muss 0 (Argument erforderlich) bleiben, sonst mischt Alfred eigene Treffer unter.
- `src/prefs.plist` = Kirills lokale Konfig (keyword=cc); gitignored, build.sh packt sie nicht ein.

## Release
Version in `src/info.plist` hochzählen → `./build.sh` → `gh release create v<version> dist/*.alfredworkflow`.

## Stand
- 21.09.2026: GitHub public (`Bonobo007/alfred-claude-code-projects`), Release v1.1.
- 22.09.2026: v1.2 = AppleScript statt ⌘N (Tipp von FireFingers21 im Forum), keine Accessibility-Berechtigung mehr nötig.
- 21.09.2026: Post in alfredforum.com „Share your Workflows“ abgeschickt (Account `kirilldesign`), wartet auf Moderator.
- Gallery: nur auf Einladung, wenn der Workflow im Forum als stabil gilt. Offen: Einladung abwarten.
