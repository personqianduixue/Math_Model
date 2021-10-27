#!/usr/bin/python

import distances
import fnmatch
import os
import ranking
import sys

if len(sys.argv) != 2:
    print 'usage: ', sys.argv[0], ' querydirectory' 
    sys.exit(1)

querydir = sys.argv[1]


print 'Computing ranking...'

ranking.compute(querydir)

