#!/bin/bash

# ------------------------------------------------------------------------------
# THIS SCRIPT DOES NOT WORK DO NOT RUN
# This simple script recursively creates sibling thumbnails for every file with
# a JPG extension and PNG file in the current directory.  If the file's name
# is foo.PNG, the duplicate file's name will be foo.png.
#
# You'll have to git add the duplicated files yourself.
# ------------------------------------------------------------------------------

THUMBNAIL_WIDTH=500

converted=0
notConverted=0
while read image
do
    nonModifiedSuffix="$(echo "${image##*.}")"
    suffix="$(echo "${image##*.}" | tr 'A-Z' 'a-z')"
    if [[ "$image" =~ \.small\.${suffix}$ ]]; then
        echo -ne
        # echo "$image is already a thumbnail."
    else
        # For those curious about the ${image##*.} and ${image%.*} syntax, man
        # bash, then use "/" to search for "parameter expansion".
        imageNameWithoutSuffix="${image%.*}"
        imageNameWithoutSuffix="$(basename "$imageNameWithoutSuffix")"
        dir="$(dirname "$image")"
        thumbnailName="${imageNameWithoutSuffix}.${suffix}"
        destination="$dir"/"$thumbnailName"

        rm "$image'z'"
        rm "${image}z"

        if [[ "$image" =~ /photo-dump/ ]]; then
            # Don't generate thumbnails for the photo-dump; those are supposed
            # to be refiled and our websites aren't going to link to it
            # anyway.
            continue
        fi

        if [[ (! -e "$destination") || "$image" -nt "$destination" ]]; then
            # Convert the foo.JPG / foo.PNG to a foo.jpg / foo.png respectively
            # echo cp "$image" "${$image"z"}"
            # echo rm "$image"
            # echo cp ${$image"z"} "$destination"

            # cp "$image" ${$image"z"}
            # rm "$image"
            # cp ${$image"z"} "$destination"

            converted="$((converted + 1))"
        else
            echo "$image already is lowercase."
            # echo cp "$image" "$image'z'"
            # # echo rm "$image"
            # echo cp "$image'z'" "$destination"

            # cp "$image" "$image'z'"
            # rm "$image"
            # cp "$image'z'" "$destination"
            notConverted="$((notConverted + 1))"
        fi
    fi
done < <(find . -iname "*.png" -or -iname "*jpg" -or -iname "*.jpeg" -or -iname "*.gif")

echo "Generated $converted new thumbnails and skipped $notConverted up-to-date thumbnails."
exit 0
