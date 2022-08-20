#!/user/bin/python3
######
from pathlib import Path
import os
print(Path.home())
os.chdir(Path.home())
os.chdir('old_files')
mydir = os.getcwd()
filelist = [f for f in os.listdir(mydir)]
for f in filelist:
    os.remove(os.path.join(mydir, f))
####
