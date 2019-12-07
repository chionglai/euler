#!/usr/bin/env python

import time
import lcc.lcc_math as lm

"""
Algorithm:
This is based on the algorithm at 
https://math.stackexchange.com/questions/316376/how-to-calculate-these-totient-summation-sums-efficiently

The idea is:
1. Counting {a, b: 0 < a < b < N}, we have
   F(N) = |{a, b: 0 < a < b < N}| = N * (N - 1) / 2
2. Let R(N) = |{a, b: 0 < a < b < N, gcd(a, b) == 1}|, we can
   generalise R(floor(N/m)) = |{a, b: 0 < a < b < N, gcd(a, b) == m}|
3. Hence, we can rewrite F(N) = sum_{m=1}^{N-1} R(floor(N / m)).
4. We need to solve for R(N), i.e.
   R(N) = F(N) - sum_{m=2}^{N-1} R(floor(N / m)),
   Note the recursion.
"""

rDict = {}

def F(N):
    """
    Calculate the number of samples, such that {a, b: 0 < a < b < N},
    which is essentially a "triangle"
    """
    return N * (N - 1) // 2


def R(N):
    """
    Recursion. Working but slow.
    """
    if N < 2:
        return 0
    if N == 2:
        return 1
    if N in rDict.keys():
        return rDict[N]

    total = F(N)
    # This reversal is important to speed things up.
    for m in range(N-1, 1, -1):
        total -= R(N // m)

    rDict[N] = total
    return total

'''
def R(N):
    """
    Recursion. Not working yet. The loop can be optimised.
    """
    if N < 2:
        return 0
    if N == 2:
        return 1
    if N in rDict.keys():
        return rDict[N]

    total = F(N)

    #m = range(2, N)
    #x = N // m
    # count number of duplicate and reduce the list to
    # contain unique values

    x = 2
    while x <= N // 2:
        total -= R(x) * (N // x - N // (x+1))
        x += 1

    rDict[N] = total
    return total
'''

# Takes about 36s for N = 1 mil
N = 1000000

tic = time.time()

res = R(N)

toc = time.time()

print "Result = %d, in %f s" % (res, toc - tic)
