CONFIGS_PATH="/opt/retropie/configs"
INSTALLED_SYSTEMS="$(ls -1 $CONFIGS_PATH)"
INSTALLED_SYSTEMS="${INSTALLED_SYSTEMS/all/}"

failed=()
success=()

for system in $INSTALLED_SYSTEMS; do
    destination="${CONFIGS_PATH}/${system}/launching.png"
    target="./assets/launching/${system}/launching.png"

    if ! [[ -f "$target" ]]; then
        failed+=($system)
        continue
    fi
    
    if ! [[ -d "${destination/launching.png/}" ]]; then
        failed+=($system)
        echo "SKIPPING. ${destination/launching.png/} does not have a folder in ${CONFIGS_PATH}"
        continue
    fi

    # Main copy command.
    cp $target $destination

    echo "FOUND. $system: Launch image copied to $destination"

    success+=($system)
done

echo "
DONE. Successfully copied images to the following systems: ${success[@]}"
