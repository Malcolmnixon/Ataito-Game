#!/bin/bash
CURRENT_DIR=$(dirname "$(readlink -f "$0")")
APK="$CURRENT_DIR/build/Ataito.apk"

echo Uploading to Itch...
butler -v push "$APK" "malcolmnixon/ataito-the-spirit-swapper:android"

echo Done.
