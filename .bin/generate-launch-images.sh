CONFIGS_PATH="/opt/retropie/configs"
ART_PATH="./assets/art"
LAUNCHING_PATH="./assets/launching"
LAUNCHING_TEMPLATE_FILE="$LAUNCHING_PATH/template.png"
THEME_PATH="${ART_PATH}/systems"
THEME_SYSTEMS="$(ls -1 $THEME_PATH)"
OUTPUT_PATH="./assets/launching"

success=()

convert_cmd=(convert -background none -resize "x235>" -resize "640x>")

for file in $THEME_SYSTEMS; do
    system="${file/.svg/}"
    logo="${THEME_PATH}/${file}"
    lineart="${ART_PATH}/lineart/${file}"
    launching="${LAUNCHING_PATH}/${system}/launching.png"
    test_path="${LAUNCHING_PATH}/tmp/${system}.png"

    if [[ -f "$launching" ]]; then
        echo "SKIPPING. ${launching} already exists."
        continue
    fi

    echo "Generating launching image for $system"

    ${convert_cmd[@]} "$logo" "./tmp/${system}.png"
    convert "$lineart" -background none "./tmp/${system}.lineart.png"

    logo="./tmp/${system}.png"
    lineart="./tmp/${system}.lineart.png"

    if ! [[ -f "./tmp/${system}.png" ]]; then
        echo "ERROR for ${system}: it seems that we had some problem when converting the SVG file to PNG!".
        continue
    fi

    if ! [[ -f "./tmp/${system}.lineart.png" ]]; then
        echo "ERROR for ${system}: it seems that we had some problem when converting the SVG file to PNG!".
        continue
    fi

    launching="./tmp/${system}.lineart.png"
    
    convert "$launching" \
        -fill "#342e18" \
        -colorize 100 \
        -background none \
        -rotate "-35" \
        "$lineart" \
    && convert "$LAUNCHING_TEMPLATE_FILE" \
        -gravity center "$lineart" \
        -geometry +0-45 \
        -composite "$launching" \
    && convert "$launching" \
        -gravity center "$logo" \
        -composite "$launching"

    mkdir -p "${OUTPUT_PATH}/${system}"
    mv "$launching" "${OUTPUT_PATH}/${system}/launching.png"

    success+=($system)
done

rm -r ./tmp

echo "
DONE. Successfully generated images in ${OUTPUT_PATH}."
