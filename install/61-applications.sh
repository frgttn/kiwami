#!/bin/bash

set -euo pipefail

APPLICATIONS_SOURCE="$KIWAMI_PATH/applications"
APPLICATIONS_TARGET="$HOME/.local/share/applications"

if [[ ! -d "$APPLICATIONS_SOURCE" ]]; then
  echo "Applications source not found: $APPLICATIONS_SOURCE" >&2
  exit 1
fi

mkdir -p "$APPLICATIONS_TARGET"
cp -a "$APPLICATIONS_SOURCE/." "$APPLICATIONS_TARGET/"

update-desktop-database "$APPLICATIONS_TARGET"
