SET CURRENT_DIR=%~dp0
SET APK=%CURRENT_DIR%/build/quest/Ataito.apk
SET WINDOWS=%CURRENT_DIR%/build/windows/

echo Uploading to Itch...
butler -v push "%APK%" "malcolmnixon/ataito-the-spirit-swapper:android"
butler -v push "%WINDOWS%" "malcolmnixon/ataito-the-spirit-swapper:windows"

echo Done.
