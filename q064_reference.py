#!/usr/bin/env python

import time

import numpy as np

from lcc.lcc_math import isSquare

"""
Method #2: from forum
Let n_i / (sqrt(x) - k_i) be the current fraction we are dealing with. We know that
a_i = floor( n_i / (sqrt(x) - k_i) ). This value can be computed.

The original fraction can also be simplified, as the problem demonstrated:

n_i / (sqrt(x) - k_i) = n_i * (sqrt(x) + k_i) / (x - k_i^2 = (sqrt(x) + k_i) / ( (x - k_i^2)/n_i )

We can now subtract a_i to find the reciprocal of the next fraction:

(n_{i+1} / (sqrt(x) - k_{i+1})^(-1) = (sqrt(x) + k_i) / ( (x - k_i^2)/n_i ) - a_i
    = ( sqrt(x) - (a_i * (x - k_i^2) / n_i) - k_i ) / ( (x - k_i^2)/n_i )

And thus we can conclude n_{i+1} = (x ? k_i^2) / n_i and
k_{i+1} = a_i * (x - k_i^2) / n_i - k_i = a_i * n_{i+1} - k_i.
"""
def calcFractionPeriod(num):
    sqrtN = np.sqrt(num)
    k_i = int(np.floor( sqrtN ))
    n_i = 1
    period = 0

    while True:
        period += 1
        a_i = int( n_i / (sqrtN - k_i) )
        n_i = (num - k_i ** 2) / n_i
        k_i = a_i*n_i - k_i

        if n_i == 1:
            # Period is found when the numerator becomes 1 again.
            break

    return period


tic = time.time()

N = 10000
resList = {}
oddCount = 0
for num in range(2, N+1):
    if not isSquare(num):
        c = calcFractionPeriod(num)
        if c % 2 == 1:
            oddCount += 1

toc = time.time()

res = oddCount

print "Result = %d, in %f s" % (res, toc - tic)