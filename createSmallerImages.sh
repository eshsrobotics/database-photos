# setup
totalPNG=0
totalJPG=0
totalJPEG=0
totalFiles=0

IFS=$'\n'; set -f

echo "This script converts .png files to .jpg files, if any are found. Additionally, this script converts high resolution jpeg images to lower resolution ones, with two varying sizes. So, there are three sizes for every jpeg."
echo
# png
for f in $(find . -name '*.png' -or -name '*.PNG');
do
  totalPNG=$((totalPNG+1))

  echo "Found: "$totalPNG": "$f"";
  lengthMinuxFileEnding="$(("${#f}" - 3))"
  # https://unix.stackexchange.com/a/303967
  fNew="${f%????}"
  echo "${fNew}.png"
  echo "${fNew}.jpg"
  convert "${fNew}.png" "${fNew}.jpg"
done

# # jpg
# for f in $(find . -name '*.jpg' -or -name '*.JPG');
# do
#   totalJPG=$((totalJPG+1))

#   echo "jpg: "${totalJPG}" "${f}"";
#   lengthMinuxFileEnding="$(("${#f}" - 3))"
#   # https://unix.stackexchange.com/a/303967
#   fNew="${f%????}"

  
# done

# jpeg
for f in $(find . -name '*.jpeg' -or -name '*.JPEG');
do
  totalJPG=$((totalJPEG+1))

  echo "jpeg: "${totalJPEG}" "${f}"";

done

# find all items in all subdirs
for f in $(find .);
do
  totalFiles=$((totalAll+1))
done

# output
echo
echo "Total PNG: "$totalPNG""
echo "Total JPG: "$totalJPG""
echo "Total JPEG: "$totalJPEG""
echo "Total All (including non-originals): "$totalFiles""

unset IFS; set +f
