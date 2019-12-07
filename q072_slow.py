#!/usr/bin/env python

import time
import numpy as np
import lcc.lcc_math as lm

"""
Algorithm:
The total reduced proper fraction is given by the sum of the Totient sum 
from 2 <= n <= N. This is not very efficient and can be easily improved
for prime number, i.e.
1. For each prime number p, there are (p-1) proper fractions.
2. For each non-prime n, its number of reduced proper fraction is
   totientSum(n).

However, this is still not very efficient.
"""

N = 100

tic = time.time()
pList = np.array(lm.genPrimeEx(N))

primeCount = sum(pList) - len(pList)

nonprimeCount = 0
i = 1
while i < len(pList):
    for nonPrime in range(pList[i-1]+1, pList[i]):
        nonprimeCount += lm.totientSum2(nonPrime)
    i = i + 1

if pList[-1] < N:
    for nonPrime in range(pList[-1]+1, N+1):
        nonprimeCount += lm.totientSum2(nonPrime)

res = primeCount + nonprimeCount
toc = time.time()

print "Result = %d, in %f s" % (res, toc - tic)
