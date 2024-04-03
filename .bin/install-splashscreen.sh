SPLASHSCREEN_PATH="$HOME/RetroPie/splashscreens"
THEME_SPLASHSCREEN_PATH="./assets/splashscreens"

if ! [[ -d $SPLASHSCREEN_PATH ]]; then
    mkdir $SPLASHSCREEN_PATH
fi

echo "
Copying splashscreens from $THEME_SPLASHSCREEN_PATH to $SPLASHSCREEN_PATH"

cp "$THEME_SPLASHSCREEN_PATH/"* $SPLASHSCREEN_PATH

echo "Done."