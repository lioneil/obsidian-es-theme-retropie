# TODO: add more games
# format:
# [custom-collection]:"game1;game2;case-insensitive;supports spaces;etc"
typeset -A GAMES=(
    [artoffighting]="aof;art of fighting;the art of fighting"
    [asterix]="asterix;obelix"
    [contra]="contra;super contra"
    [darkstalkers]="darkstalkers;dstlk;vhunt;vsav"
    [earthwormjim]="earthwormjim;earthworm jim"
    [fatalfury]="fatalfury;fatal fury;rbff;fatfur;garou"
    [finalfight]="finalfight;final fight;ffight"
    [jojo]="jojo;jojoba"
    [kof]="kof;king of fighter;the king of fighter"
    [marvelvscapcom]="mvsc;marvelvscapcom;mshvsfa;msh;xmcota;xmvsf;Marvel vs. Capcom;Marvel Superheroes vs.;X-Men vs."
    [megamanx]="megamanx;megaman x;SLUS-00561;SLUS-01334;SLUS-01395"
    [metalslug]="metalslug;Metal Slug;mslug"
    [metroid]="metroid;Super Metroid"
    [pokemon]="pokemon;pokémon"
    [powerinstinct]="powerinstinct;powerins;pwrinst;groovef;Power Instinct"
    [romhacks]="romhacks;sfiii3an;sfz3mix;Clock Tower Deluxe"
    # careful not to add just "sonic",
    # because it will pickup "Sonic Wings", and other non-hedgehog games
    [sonic]="sonic the hedgehog;sonic and knuckles;sonic & knuckles"
    [streetfighter]="sf1;sf2;sfii;street fighter;hsf;ssf;sfa;sfz"
    [streetsofrage]="streetsofrage;streets of rage;bare knuckle;mt_srage;mp_sor"
    [supermario]="super mario"
    [tmnt]="tmnt;teenage mutant ninja turtles;"
)

COLLECTIONS="$(ls -1 ./)"
COLLECTIONS="${COLLECTIONS}"

ES_COLLECTIONS_PATH="$HOME/.emulationstation/collections"

INSTALLED_SYSTEMS="$(ls -1 /opt/retropie/configs)"
INSTALLED_SYSTEMS="${INSTALLED_SYSTEMS/all/}"
ROMS_PATH="$HOME/RetroPie/roms"

shopt -s nocasematch

while getopts 'f' OPTION; do
    case "$OPTION" in
        f) echo "Deleting custom collections in ${ES_COLLECTIONS_PATH} first"
            rm -r "${ES_COLLECTIONS_PATH}/custom-"*;;
        ?) echo "Script usage: $(basename \$0) [-f]" >&2
            exit 1 ;;
    esac
done

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
                if [[ $file = $filename* ]]; then
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
        echo "-----------"
        printf "%s\n" "${collected[@]}" > "$ES_COLLECTIONS_PATH/$name"
    fi
done

echo "
Done."