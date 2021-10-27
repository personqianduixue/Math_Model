#!/usr/bin/python

import sys

def find(query, maxdist):
    artistsfilename = 'uspop2002artists.txt'
    matrixfilename = 'matrix_uspop_mtg.dat'

    artistsfile = open(artistsfilename, 'r')
    artists = [ s.strip() for s in artistsfile.readlines() ]
    matrixfile = open(matrixfilename, 'r')

    try:
        queryindex = artists.index(query)
    except ValueError:
        print 'unknown artist:', query
        sys.exit(1)


    s = ''
    for i in range(queryindex + 1):
        s = matrixfile.readline().strip()
    
    l = s.split()
    result = []

    for dist in range(maxdist):
        for i in range(len(l)):
            if int(l[i]) == dist:
                result.append((artists[i], dist))
    return result
