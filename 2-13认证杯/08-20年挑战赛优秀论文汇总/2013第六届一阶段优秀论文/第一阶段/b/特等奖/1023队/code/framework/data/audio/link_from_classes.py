#!/usr/bin/python

# this script will link all files in a class file (given a class file and a base
# directory as argument) into the current directory. It replicates the whole directory
# structure so you can mess with your new audio library without fear of destroying
# the original one

import os.path
import sys;

if len(sys.argv) != 3:
    print 'usage: ', sys.argv[0], ' classfile basedirectory' 
    sys.exit(1)

f = open(sys.argv[1], 'r')
l = [ s.strip() for s in f.readlines() ]

basedir = sys.argv[2]

for x in l:
    ll = x.split()
    for filename in ll[1:]:
        directory = os.path.dirname(filename)
        os.system('mkdir -p ' + directory)
        cmd = 'ln -s "' + basedir + '/' + filename + '" ' + filename
        os.system(cmd)

