#!/bin/bash
# Creating files

mkdir -p $HOME/old_files/

for i in {1..10}
do
	touch $HOME/old_files/test.$i 
done
# End of script
