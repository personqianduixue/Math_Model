#!/usr/bin/python

# returns the artists at distance from the given one less
# than the distance specified as argument

import sys
import similar_artists

query = sys.argv[1]
maxdist = int(sys.argv[2])

result = similar_artists.find(query, maxdist)

for r in result:
    print r
