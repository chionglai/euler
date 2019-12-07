#!/usr/bin/env python

import time
import math as m
import itertools as it
import lcc.lcc_math as lm
import numpy as np

"""
Algorithm:
Based on the Totient sum formula, phi(n) = n * prod(1 - 1/p) for all prime p
that divides n. For n / phi(n) to be minimum, prod(1 - 1/p) needs to be max.
For prod(1 - 1/p) to be max, there needs to be as few prime factor, p that 
divides n. The best is to have n to be prime. However, if n is prime, then
its totient sum is equals to n - 1, which will never be digit permutation of
n. So, the next best thing is to have 2 prime factors, p0 and p1 for n.
Then, n = p0 * p1 and its totient sum is (p0 - 1) * (p1 - 1). For
(p0 - 1) * (p1 - 1) to be maximum, we need to search near sqrt(10**7). One
way is to constrain the prime number to be 4-digits, so generating
prime numbers between 1000 to 10000, since the min * max should be < 10**7.

1. Generate a list of prime numbers, ordered in descending order as the search space.
2. Select 2 prime numbers as combinations from the list.
3. Calculate n = prod(p), and totientSum = prod(p - 1). Determine if they 
   are digit permutation of each other.
4. Find n that corresponds to minimum n / phi(n).
"""

# Max search valuefor n
N = 10**7
minPrime = 1000
maxPrime = N / minPrime
# Number of prime factor to search. nStart is inclusive, nEnd is exclusive
nStart = 2
nEnd = 3

tic = time.time()

# prime numbers below 10000 happens to include the solution. Search space
# can be further reduced by brute force.
pList = lm.genPrimeEx(maxPrime)
pList = pList[::-1]
pShortList = it.ifilter(lambda x: x >= minPrime, pList)

candidate = []
for nFac in range(nStart, nEnd):
    comb = it.combinations(pShortList, nFac)
    pSubList = it.ifilter(lambda x: np.prod(x) < N, comb)
    for c in pSubList:
        n = np.prod(c)
        totientSum = np.prod(np.array(c) - 1)
        if sorted(str(n)) == sorted(str(totientSum)):
            candidate.append((n, totientSum, c))

# Sort in ascending order based on n / phi(n). n is the first
# value in the tuple and phi(n) is the second.
candidate.sort(key=lambda x: float(x[0])/x[1])
res = candidate[0][0]

toc = time.time()

print "Result = %d, in %f s" % (res, toc - tic)
