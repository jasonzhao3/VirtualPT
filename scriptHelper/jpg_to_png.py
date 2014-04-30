from PIL import Image
# import Image as PillowImage
from os import listdir
from os.path import isfile, join


path = '../hep2go/png/'
onlyfiles = [ f for f in listdir(path) if isfile(join(path,f)) ]
print onlyfiles

for img_file in onlyfiles:
	print img_file