#!/usr/bin/env python

import time
import lcc.lcc_math as lm
import collections as c


"""
Algorithm:
1. Any prime with more than 1 digit must not contain any of these digits, since then their circular
   will never be prime.
        0, 2, 4, 6, 8, 5
"""

N = 10**6

tic = time.time()

# any prime with more than 1 digit must not contain any of these digits
nonSet = set('024685')

pList = lm.gen_prime(N)

# filter all prime containing 1, 2, 4, 6, 8, 5 digits
pList = [p for p in pList if p > 100 and nonSet.isdisjoint(set(str(p)))]

solList = [2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, 97]   # given solution below 100
while len(pList) > 0:
    p = pList[0]
    dig = c.deque(str(p))

    cand = [p]
    for _ in range(len(dig) - 1):
        dig.rotate(1)
        pNext = int("".join(dig))
        if pNext in pList:
            cand.append(pNext)
        else:
            # not circular prime
            break
    else:
        solList.extend(cand)

    for p1 in cand:
        pList.remove(p1)

toc = time.time()

res = len(solList)

print "Result = %d, in %f s" % (res, toc - tic)