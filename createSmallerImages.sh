#!/bin/bash

# ------------------------------------------------------------------------------
# This simple script recursively creates sibling thumbnails for every JPG and
# PNG file in the current directory.  If the file's name is foo.png, the
# thumbnail's name will be foo.small.png.
#
# You'll have to git add the generated thumbnails yourself.
# ------------------------------------------------------------------------------

THUMBNAIL_WIDTH=500

converted=0
notConverted=0
while read image
do
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
        thumbnailName="${imageNameWithoutSuffix}.small.${suffix}"
        destination="$dir"/"$thumbnailName"

        if [[ "$image" =~ /photo-dump/ ]]; then
            # Don't generate thumbnails for the photo-dump; those are supposed
            # to be refiled and our websites aren't going to link to it
            # anyway.
            continue
        fi

        if [[ (! -e "$destination") || "$image" -nt "$destination" ]]; then
            # ImageMagick's default quality is 92 (out of 100.)
            # ImageMagick's default PNG compression is already 75 (out of 100.)
            echo Calling: convert -geometry $THUMBNAIL_WIDTH -quality 75 "$image" "$destination"
            convert -geometry $THUMBNAIL_WIDTH -quality 75 "$image" "$destination"
            converted="$((converted + 1))"
        else
            echo "$image already has a recent thumbnail ($destination)."
            notConverted="$((notConverted + 1))"
        fi
    fi
done < <(find . -iname "*.png" -or -iname "*jpg" -or -iname "*.jpeg" -or -iname "*.gif")

echo "Generated $converted new thumbnails and skipped $notConverted up-to-date thumbnails."
exit 0
