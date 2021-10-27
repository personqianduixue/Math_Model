#!/usr/bin/python

import distances
from distances import mtg_score, uspop2002_score
import glob
import os
import sys


def compute(querydir):
    # compute ranking
    total = len(glob.glob1(querydir, '*.query'))
    current = 0
    overlap, queries = 0, 0
    failed = 0
    mtg_topn, uspop2002_topn = 0.0, 0.0
    mtg_mtgdistance, mtg_mtgdistance2 = 0.0, 0.0
    uspop2002_mtgdistance, uspop2002_mtgdistance2 = 0.0, 0.0

    for f in glob.glob1(querydir, '*.query'):
        current += 1
        print '\r[' + str(current) + '/' + str(total) + ']',
        sys.stdout.flush()
        queryfilename = os.path.join(querydir, f)
        queryfile = open(queryfilename, 'r')
        expected = [ s.strip() for s in queryfile.readlines() ]
        expected = expected[1:] # skip song name
        queryfile.close()
        queries += 1
        # do computation here....
        try:
            resultfile = open(queryfilename + '.result', 'r')
            result = [ s.strip() for s in resultfile.readlines() ]
            overlap += distances.common_items(expected, result)
            mtg_topn += mtg_score(distances.topNrankagree, expected, result)
            mtg_mtgdistance += mtg_score(distances.mtg_distance, expected, result)
            mtg_mtgdistance2 += mtg_score(distances.mtg_distance2, expected, result)
            uspop2002_topn += uspop2002_score(distances.topNrankagree, expected, result)
            uspop2002_mtgdistance += uspop2002_score(distances.mtg_distance, expected, result)
            uspop2002_mtgdistance2 += uspop2002_score(distances.mtg_distance2, expected, result)
        except:
            failed += 1
        

    print
    print 'Total queries:', queries, '- failed:', failed
    print 'Average overlap:', float(overlap)/queries, 'common similar artists (out of 10)'
    print 'Using MTG matrix as reference:'
    print '  topNrankagree distance:', mtg_topn/queries
    print '  MTG distance:', mtg_mtgdistance/queries
    print '  MTG distance2:', mtg_mtgdistance2/queries
    print 'Using uspop2002 matrix as reference:'
    print '  topNrankagree distance:', uspop2002_topn/queries
    print '  MTG distance:', uspop2002_mtgdistance/queries
    print '  MTG distance2:', uspop2002_mtgdistance2/queries

