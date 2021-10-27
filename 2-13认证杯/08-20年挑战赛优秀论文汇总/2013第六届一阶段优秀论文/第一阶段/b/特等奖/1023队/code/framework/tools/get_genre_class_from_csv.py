#!/usr/bin/python

# prints a genre classfile on the standard output given
# a csv file containing the files.
# if you want top save it in a file, use the following:
# ./get_genre_class_from_csv.py tracklist.csv > genre.classes

import random
import sys

f = open(sys.argv[1], 'r')
l = [ s.strip() for s in f.readlines() ]

names = []
classes = []

for s in l:
    spl = s.split(',')
    try:
        i = names.index(spl[0][1:-1])
        classes[i].append(spl[5][1:-1])
    except ValueError:
        names.append(spl[0][1:-1])
        classes.append([spl[5][1:-1]])


for i in range(len(names)):
    print names[i],
    for x in classes[i]:
        print x,
    print
