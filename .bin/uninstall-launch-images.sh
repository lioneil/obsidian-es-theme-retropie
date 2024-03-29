CONFIGS_PATH="/opt/retropie/configs"
INSTALLED_SYSTEMS="$(ls -1 $CONFIGS_PATH)"
INSTALLED_SYSTEMS="${INSTALLED_SYSTEMS/all/}"

failed=()
success=()

for system in $INSTALLED_SYSTEMS; do
    destination="${CONFIGS_PATH}/${system}/launching.png"
    
    if ! [[ -f "${destination}" ]]; then
        failed+=($system)
        echo "SKIPPING. ${destination/launching.png/} does not have a launching.png file"
        continue
    fi

    # Main remove command.
    rm $destination

    echo "FOUND. $system: Launch image removed in $destination"

    success+=($system)
done

echo "
DONE. Successfully removed images from the following systems: ${success[@]}"
