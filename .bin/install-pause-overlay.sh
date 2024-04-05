SELECTED_SYSTEM=$1
PAUSE_OVERLAY_INSTALL_PATH="$HOME/.config/retroarch/overlays/pause"
PAUSE_OVERLAY_PATH="./assets/pause"
SELECTED_PAUSE_OVERLAY="$PAUSE_OVERLAY_PATH/$SELECTED_SYSTEM"
SELECTED_RETROARCH_CONFIG="all"
RETROARCH_CONFIG_FILE="/opt/retropie/configs/$SELECTED_RETROARCH_CONFIG/retroarch.cfg"
SUPPORTED_PAUSE_OVERLAYS="$(ls -1 $PAUSE_OVERLAY_PATH)"

if [[ $SELECTED_SYSTEM == "" ]]; then
    echo "Please specify your desired Pause Overlay"
    echo "List of available Pause Overlays:"
    echo ""
    echo "all (install all overlays below)"
    echo "$(ls -1 $PAUSE_OVERLAY_PATH)"
    echo ""
    echo "Sample usage:"
    echo " $0 generic"
    exit
fi

# ==============================================================================
# Global Functions
# ==============================================================================

set_retroarch_config () {
    RETROARCH_CONFIG_FILE="/opt/retropie/configs/$1/retroarch.cfg"
}

install_pause_overlay () {
    overlay=$1
    echo "----------------------------"
    echo "Installing $overlay"

    SELECTED_PAUSE_OVERLAY="$PAUSE_OVERLAY_PATH/$overlay"
    if ! [[ -f "${SELECTED_PAUSE_OVERLAY}/obsidian-$overlay-pause-overlay.cfg" ]]; then
        echo "ERROR: $overlay is not a valid Pause Overlay selection"
        echo "List of available Pause Overlays:"
        echo "$(ls -1 $PAUSE_OVERLAY_PATH)"
        exit
    fi

    if ! [[ -f "$PAUSE_OVERLAY_INSTALL_PATH" ]]; then
        mkdir -p "$PAUSE_OVERLAY_INSTALL_PATH"
    fi

    cp -r "$SELECTED_PAUSE_OVERLAY" "$PAUSE_OVERLAY_INSTALL_PATH/"

    echo "Copied $SELECTED_PAUSE_OVERLAY to $PAUSE_OVERLAY_INSTALL_PATH"

    # --------------------------------------------------------------------------
    # Modify retroarch.cfg to use the pause overlay
    # --------------------------------------------------------------------------
    ACTIVE_PAUSE_OVERLAY_FILE="$PAUSE_OVERLAY_INSTALL_PATH/$SELECTED_SYSTEM/obsidian-$SELECTED_SYSTEM-pause-overlay.cfg"
    cp $RETROARCH_CONFIG_FILE "${RETROARCH_CONFIG_FILE}.bak"
    echo "Replacing values in $RETROARCH_CONFIG_FILE"
    echo "input_overlay_enable = true"
    sed -i "/input_overlay_enable/s/=.*/= true/" $RETROARCH_CONFIG_FILE

    echo "input_overlay = \"$ACTIVE_PAUSE_OVERLAY_FILE\""
    sed -i "/^# input_overlay /s|# input_overlay =|input_overlay =|" $RETROARCH_CONFIG_FILE
    sed -i "/^input_overlay /s|=.*|= \"$ACTIVE_PAUSE_OVERLAY_FILE\"|" $RETROARCH_CONFIG_FILE

    echo ""
    echo "DONE"
}

# ==============================================================================
# Install All Pause Overlays
# ==============================================================================

if [[ $SELECTED_SYSTEM == "all" ]]; then
    set_retroarch_config "all"
    echo "Installing all Pause Overlays"

    for overlay in $SUPPORTED_PAUSE_OVERLAYS; do
        install_pause_overlay $overlay
    done

    exit
fi

if [[ $SELECTED_SYSTEM == "generic" ]]; then
    set_retroarch_config "all"
    install_pause_overlay $SELECTED_SYSTEM
    exit
fi

# ==============================================================================
# Install Specific Pause Overlays
# ==============================================================================

set_retroarch_config $SELECTED_SYSTEM
install_pause_overlay $SELECTED_SYSTEM
