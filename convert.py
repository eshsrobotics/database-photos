# pip install Pillow
# Python Version: Python 2.7.15rc1 (and most likely others, see Pillow compatability chart)
# Pillow installation and compatability table here: https://pillow.readthedocs.io/en/stable/installation.html
# Using 5.4.1 on my system: https://pillow.readthedocs.io/en/stable/releasenotes/5.4.1.html?highlight=5.4.1
import os
from PIL import Image

foundImages = []
def searchFiles(directory='.', extension=''):
  extension = extension.lower()
  for dirpath, dirnames, files in os.walk(directory):
    for name in files:
      if extension and name.lower().endswith(extension):
        # print(os.path.join(dirpath, name))
        # Only add the file if it has the same extension
        foundImages.append(os.path.join(dirpath, name))
      elif not extension:
        print(os.path.join(dirpath, name))


print("Converting .png images to .jpg")
searchFiles(".", ".png")
for image in foundImages:
  im = Image.open(image)
  rgp_im = im.convert("RGB")
  newName = os.path.splitext(image)[0] + '.jpg'
  rgp_im.save(newName)
  # Image.close()


print("Creating smaller versions of .png images")
searchFiles(".", ".jpg")
  im = Image.open(image)

  # Old Numbers
  x = im.size[0]
  y = im.size[1]
  ratio = y / float(x)

  # New Numbers
  widthXSmall = 500
  widthYSmall = widthXSmall * ratio

  im = im.resize((int(widthXSmall),int(widthYSmall)),Image.ANTIALIAS)
  newName = os.path.splitext(image)[0] + '.small.jpg'
  im.save(newName,optimize=True,quality=85)
