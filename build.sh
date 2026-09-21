#!/bin/bash
# Packs src/ into dist/Claude Code Projects-<version>.alfredworkflow (a plain zip).
set -euo pipefail
cd "$(dirname "$0")"
version=$(/usr/libexec/PlistBuddy -c 'Print :version' src/info.plist)
out="dist/Claude Code Projects-${version}.alfredworkflow"
mkdir -p dist
rm -f "$out"
(cd src && zip -q -X -r "../$out" . -x '.DS_Store' 'prefs.plist')
echo "$out"
