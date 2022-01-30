#!/bin/bash
CURRENT_DIR=$(dirname "$(readlink -f "$0")")
GODOT="$HOME/bin/Godot Standard/Godot_v3.4.2-stable_x11.64"
APK="$CURRENT_DIR/build/Ataito.apk"

echo Exporting APK...

if [ !-d "$CURRENT_DIR/build" ]; then
	mkdir "$CURRENT_DIR/build"
fi

"$GODOT" --export "Android" "$APK"

echo Done.
