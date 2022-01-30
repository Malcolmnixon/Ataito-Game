#!/bin/bash
CURRENT_DIR=$(dirname "$(readlink -f "$0")")
APK="$CURRENT_DIR/build/Ataito.apk"
WINDOWS="$CURRENT_DIR/build/windows/"

echo Uploading to Itch...
butler -v push "$APK" "malcolmnixon/ataito-the-spirit-swapper:android"
butler -v push "$WINDOWS" "malcolmnixon/ataito-the-spirit-swapper:windows"

echo Done.
