# TODO: add more games
# format:
# [custom-collection]:"game1;game2;case-insensitive;supports spaces;etc"
typeset -A GAMES=(
    [asterix]="asterix;obelix"
    [contra]="contra"
    [darkstalkers]="darkstalkers;dstlk;vhunt;vsav"
    [earthwormjim]="earthwormjim;earthworm jim"
    [fatalfury]="fatalfury;fatal fury;rbff;fatfur;garou"
    [finalfight]="finalfight;final fight;ffight"
    [streetfighter]="sf1;sf2;sfii;street fighter;hsf;ssf;sfa;sfz"
)

COLLECTIONS="$(ls -1 ./)"
COLLECTIONS="${COLLECTIONS}"

ES_COLLECTIONS_PATH="$HOME/.emulationstation/collections"

INSTALLED_SYSTEMS="$(ls -1 /opt/retropie/configs)"
INSTALLED_SYSTEMS="${INSTALLED_SYSTEMS/all/}"
ROMS_PATH="$HOME/RetroPie/roms"

shopt -s nocasematch

for collection in "${!GAMES[@]}"; do
    IFS=';'
    filenames="${GAMES[$collection]}"
    filenames=($filenames)
    unset IFS
    collected=()
    name="custom-${collection}.cfg"

    if [[ -f "${ES_COLLECTIONS_PATH}/${name}" ]]; then
        echo "SKIPPING $collection: Custom collection $name already exists."
        echo "-----------"
        continue
    fi

    for filename in "${filenames[@]}"; do
        IFS=$'\n'
        filename="${filename}"
        
        for system in $INSTALLED_SYSTEMS; do
            if ! [[ -d $ROMS_PATH/${system} ]]; then
                continue
            fi

            results="$(ls -1 $ROMS_PATH/${system})"
            
            for file in $results; do
                if [[ $file =~ $filename ]]; then
                    echo "FOUND MATCH"
                    echo "System: $system"
                    echo "File: $ROMS_PATH/${system}/$file"
                    echo "Custom collection: $collection"
                    echo "-----------"
                    file=$ROMS_PATH/${system}/$file

                    if ! [[ -f $file ]]; then
                        continue
                    fi

                    collected+=($file)
                fi
            done
        done
        unset IFS
    done


    if ! [ -z "$collected" ]; then
        echo "Adding entries to $ES_COLLECTIONS_PATH/$name"
        printf "%s\n" "${collected[@]}" > "$ES_COLLECTIONS_PATH/$name"
    fi
done

echo "
Done."