#!/usr/bin/python

import os.path
import random
import sys

# choosing function
def choose(s):
    percent = 0.05
    if random.random() < percent:
        return True
    return False


tracklistfilename = sys.argv[1]

# unpack class
tracklistfile = open(tracklistfilename, 'r')
ll = [ s.strip() for s in tracklistfile.readlines() ]
wavlist = []
for f in ll:
    l = f.split()
    for i in l[1:]:
        wavlist.append((i, l[0]))

#choose songs
names = []
classes = []
for s in wavlist:
    if choose(s):
        try:
            song, artist = s
            i = names.index(artist)
            classes[i].append(song)
        except ValueError:
            names.append(artist)
            classes.append([song])


# repack
for i in range(len(names)):
    print names[i],
    for x in classes[i]:
        print x,
    print
