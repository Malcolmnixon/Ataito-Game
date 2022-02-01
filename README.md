# Ataito The Spirit Swapper
Global Game Jam 2022 Submission - Ataito: The Spirit Swapper

## Tools
* [Godot](https://godotengine.org/), version [3.4.2](https://github.com/godotengine/godot/releases/tag/3.4.2-stable)
* A local and modified fork of the [Godot XR Tools](https://github.com/Malcolmnixon/godot-xr-tools)
* [Krita](https://krita.org/en/)
* [Audacity](https://www.audacityteam.org/)

## Links

* [Global Game Jam Entry](https://globalgamejam.org/2022/games/ataito-spirit-swapper-3)
* [Itch.io Game Page](https://malcolmnixon.itch.io/ataito-the-spirit-swapper)
* [Gameplay Video](https://www.youtube.com/watch?v=Qm1ihJlmy8Y)

## Platforms
It is built for **OpenXR**, so even though the control scheme image displays Oculus-style controllers, it will likely work for other headsets, we just don't have any ourselves to test with.
We targeted Oculus Quest 2, and know it works with the Oculus Link and an actual Oculus Rift.

## Build
### Export Notes
You'll need to create an android export, ensure the keystore options are setup, and "Xr Mode" should be "OpenXR" instead of the default (otherwise your buttons won't work right).

### Upload Note
The upload script will only work for folks with the [itch butler](https://github.com/itchio/butler) tool, logged in with a user who has admin permission to that project page.
