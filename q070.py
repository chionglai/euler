#!/usr/bin/env python

import time
import math as m
import itertools as it
import lcc.lcc_math as lm
import numpy as np

class FoundException(BaseException):
    pass


N = 10**7
nStart = 2
nEnd = 2

tic = time.time()
pList = lm.gen_prime(N/2)
# pList = pList[::-1]

sol = []
try:
    for nFac in range(nStart-1, nEnd):
        comb = it.combinations(pList, nFac)
        for c in comb:
            cProd = np.prod(c)
            pSubList = it.ifilter(lambda x: max(c) < x < float(N)/min(c), pList)
            # [p for p in pList if max(c) < p < float(N)/min(c)]
            for p in pSubList:
                c = np.array(c)

                n = np.prod(c) * p
                k = np.prod(1 - 1./c) * (1 - 1./p)
                nPerm = np.prod(c - 1) * (p - 1)

                if sorted(str(n)) == sorted(str(nPerm)):
                    # found
                    sol.append((k, n))
                    # res = n
                    # raise FoundException
except FoundException:
    pass

# res = 0
toc = time.time()


print "Result = %d, in %f s" % (res, toc - tic)