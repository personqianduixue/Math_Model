#!/usr/bin/python

import random
import sys

namesfile = open('uspop2002artists.txt', 'r')
resultfile = open(sys.argv[2], 'w')

names = [ s.strip() for s in namesfile.readlines() ]

result = random.sample(names, int(sys.argv[3]))

for artist in result:
	resultfile.write(artist + '\n')

namesfile.close()
resultfile.close()
