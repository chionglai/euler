#!/usr/bin/env python

import time
import numpy as np
import lcc.lcc_math as lm
import itertools as it

"""
Algorithm:
1. Reduce search space on the go.
"""

N = 10**7

tic = time.time()

factor1 = [44, 32, 13, 10]
fac1 = set([lm.combine_digit(l) for f in factor1 for l in it.permutations(lm.extract_digit(f))])

factor89 = [145, 42, 20, 4, 16, 37, 58]
fac89 = set([lm.combine_digit(l) for f in factor89 for l in it.permutations(lm.extract_digit(f))])

n = range(N, 1, -1)

for i in range(N, 0, -1):
    mul10 = np.log10(i)
    if mul10 == int(mul10):
        fac1.add(i)
        continue
    elif i in fac89 or i in fac1:
        continue

    # if len(fac89) + len(fac1) > 2*N/3:
    #     import pdb
    #     pdb.set_trace()

    dig = lm.extract_digit(i)
    newList = [i]
    while True:
        i2 = sum([d**2 for d in dig])
        newList.append(i2)

        mul10 = np.log10(i2)
        if mul10 == int(mul10) or i2 in fac1:
            newFac1 = set([lm.combine_digit(l) for f in newList for l in it.permutations(lm.extract_digit(f))])
            fac1 = fac1.union(newFac1)
            break
        elif i2 in fac89:
            newFac89 = set([lm.combine_digit(l) for f in newList for l in it.permutations(lm.extract_digit(f))])
            fac89 = fac89.union(newFac89)
            break

        dig = lm.extract_digit(i2)


toc = time.time()

res = len(fac89)

print "Result = %d, in %f s" % (res, toc - tic)