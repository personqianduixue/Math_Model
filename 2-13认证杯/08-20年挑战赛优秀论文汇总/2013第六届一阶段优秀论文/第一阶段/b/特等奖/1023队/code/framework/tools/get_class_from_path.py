#!/usr/bin/python

# given a base path, this script creates a class file, where each class
# is the first level in the tree hierarchy and the elements are all
# files located in this directory

import fnmatch
import os
import sys

if len(sys.argv) != 2:
    print 'usage: ', sys.argv[0], ' path'
    sys.exit(1)

path = sys.argv[1]
cutpoint = len(path)

# iterate for each artist and retrieve his songs
for artist in os.listdir(path):
    print artist,
    for root, dirs, files in os.walk(os.path.join(path, artist)):
        for f in files:
            if fnmatch.fnmatch(f, '*.wav'):
                filename = os.path.join(root, f)
                # cut root path from filename
                print filename[cutpoint:],
    print
