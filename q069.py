#!/usr/bin/env python

import time
import lcc.lcc_math as lm
import math as m
import numpy as np

"""
Algorithm:
1. Using Euler's product formula for the totient sum function,
        phi(n) = n * prod((1 - 1/p)) for all p = distinct prime number dividing n
   it can be seen that the maximum of n / phi(n) is given by the minimum of phi(n),
   which occurs when n has the maximum number of distinct prime factors.
2. Using this fact, we can generate a list of prime numbers (from smallest to highest)
   and find the longest list such that their product is <= N.
3. Then, the number n that corresponds to max n / phi(n) is given by product of that
   list.
"""

N = 1000000

tic = time.time()
pList = lm.gen_prime(int(m.sqrt(N)))

i = 5
pp = np.prod(pList[:i])
while pp < N:
    i += 1
    pp = np.prod(pList[:i])

i -= 1
pNum = np.prod(pList[:i])

res = pNum

toc = time.time()


print "Result = %d, in %f s" % (res, toc - tic)