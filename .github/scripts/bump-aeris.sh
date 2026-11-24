#!/usr/bin/env bash
# Points Casks/aeris.rb at the latest Aeris release (version + sha256). No-op if already current.
set -euo pipefail

CASK="Casks/aeris.rb"
REPO="kashmithnisakya/aeris"

tag="$(gh api "repos/$REPO/releases/latest" -q .tag_name)"
latest="${tag#v}"
current="$(sed -nE 's/^  version "([^"]+)"$/\1/p' "$CASK")"

if [ "$latest" = "$current" ]; then
  echo "aeris is up to date ($current)"
  exit 0
fi

url="https://github.com/$REPO/releases/download/$tag/Aeris-$latest.zip"
sha="$(curl -fsSL "$url" | shasum -a 256 | cut -d' ' -f1)"

sed -i.bak -E \
  -e "s/^  version \"[^\"]+\"$/  version \"$latest\"/" \
  -e "s/^  sha256 \"[0-9a-f]+\"$/  sha256 \"$sha\"/" "$CASK"
rm -f "$CASK.bak"

echo "aeris: $current -> $latest ($sha)"
if [ -n "${GITHUB_OUTPUT:-}" ]; then echo "version=$latest" >> "$GITHUB_OUTPUT"; fi
