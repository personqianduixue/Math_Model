#!/usr/bin/python

import os.path
import sys

if len(sys.argv) != 3:
    print 'usage: ', sys.argv[0], ' classfile querydirectory' 
    sys.exit(1)

tracklistfilename = sys.argv[1]
querydirectory = sys.argv[2]

# construct wavlist first
tracklistfile = open(tracklistfilename, 'r')
ll = [ s.strip() for s in tracklistfile.readlines() ]
wavlist = []
for f in ll:
    l = f.split()
    for i in l[1:]:
        wavlist.append((i, l[0]))

nbqueries = 0

for f in wavlist:
    song, artist = f
    nbqueries += 1
    queryfile = open(os.path.join(querydirectory, str(nbqueries)+'.query'), 'w')
    queryfile.write(song + '\n')
    queryfile.write(artist + '\n')
    queryfile.close()

