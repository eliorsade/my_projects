#!/bin/bash
# Creating files

mkdir -p /home/slave/old_files/

for i in {1..10}
do
	touch /home/slave/old_files/test.$i 
done
