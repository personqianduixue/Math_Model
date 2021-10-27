#!/usr/bin/python

import random

matrixfile_uspop2002 = 'tools/matrix_uspop_danellis.dat'
matrixfile_mtg = 'tools/matrix_uspop_mtg.dat'
namesfile = 'tools/uspop2002artists.txt'


def mtg_score(f, la, lb):
    return f(matrixfile_mtg, la, lb)

def uspop2002_score(f, la, lb):
    return f(matrixfile_uspop2002, la, lb)

def common_items(la, lb):
    result = 0
    for x in la:
        if lb.count(x) > 0:
            result += 1
    return result


def spearman(la, lb):
    delta = 0.0
    for x in la:
        try:
            idxb = lb.index(x)
            idxa = la.index(x)
            delta += (idxa-idxb)*(idxa-idxb)
            
        except ValueError:
            # adjust delta to compensate for the fact the item is not
            # common to both lists
            delta += 49.0

    n = len(la)
    result = 1.0 - 6.0 *delta / (n*n*n - n)
    return result


def topNrankagree(matrixfile, la, lb):
    #print la, lb
    refmatrixfile = open(matrixfile, 'r')
    refnamesfile = open(namesfile, 'r')
    alpha_r = 0.5**0.67 # reference
    alpha_c = 0.5**0.33 # candidate
    
    refmatrix = [ s.split() for s in refmatrixfile.readlines() ]
    refnames = [ s.strip() for s in refnamesfile.readlines() ]

    agree = 0

    refartist = la[0]

    lst = zip(refnames, refmatrix[refnames.index(refartist)])
    random.shuffle(lst)
    lst.sort(lambda (name1,idx1),(name2,idx2): idx1 < idx2)
    refclass = [ name for (name, idx) in lst ]
    
    score = 0.0
    rank = 0
    for candidate in lb:
        rank += 1
        refrank = refclass.index(candidate) + 1
        score += alpha_r**refrank * alpha_c**rank

    return score
    

def artist_distance(refmatrix, refnames, ref, cnd):
    refidx = refnames.index(ref)
    cndidx = refnames.index(cnd)
    return refmatrix[refidx][cndidx]


def mtg_distance(matrixfile, la, lb):
    refmatrixfile = open(matrixfile, 'r')
    refnamesfile = open(namesfile, 'r')
    
    refmatrix = [ s.split() for s in refmatrixfile.readlines() ]
    refnames = [ s.strip() for s in refnamesfile.readlines() ]

    score = 0.0

    refartist = la[0]
    dist = [ int(x) for x in refmatrix[refnames.index(refartist)] ]

    rank = 0
    for artist in lb:
        rank += 1
        idx = refnames.index(artist)
        score += dist[idx] * 1.0/(1.0+rank*rank*rank/80.0)
    
    return score

def mtg_distance2(matrixfile, la, lb):
    refmatrixfile = open(matrixfile, 'r')
    refnamesfile = open(namesfile, 'r')
    
    refmatrix = [ s.split() for s in refmatrixfile.readlines() ]
    refnames = [ s.strip() for s in refnamesfile.readlines() ]

    score = 0.0

    refartist = la[0]
    dist = [ int(x) for x in refmatrix[refnames.index(refartist)] ]

    card = [ dist.count(i) for i in range(15) ]

    rank = 0
    maxrank = 0
    for artist in lb:
        rank += 1
        idx = refnames.index(artist)
        maxrank = max(dist[idx], maxrank)
        try:
            score += 1.0 / dist[idx]
        except ZeroDivisionError:
            score += 1.0

    den = 0.0
    for i in range(1, maxrank+1):
        den += float(card[i]) / i

    try:
        result = score / den
    except ZeroDivisionError:
        result = 0.0

    return result
