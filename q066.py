#!/usr/bin/env python

import time
from lcc.lcc_math import continuedFractionSurd, expandContinuedFraction


"""
Problem:
Given,
    x^2 - D * y^2 = 1       Eq. 1

for D >=2 and D not square, find the smallest x and y that satisfy this equation.

Algorithm:
1. Reduce search space for D. Remove all squares in D.
2. For a given D, find the continued fraction of sqrt(D).
3. Once the continued fraction is found, expand the continued fraction into numerators p and denominators q.
4. The Diophantine equation satisfies:
        p[n] * q[n-1] - p[n-1] * q[n] = (-1)^(n + 1), and   Eq. 2
        p[n]^2 - D * q[n]^2 = (-1)^(n+1) * Q[n+1]           Eq. 3
   where,
    n = index and start from 0.
5. For a periodic continued fraction, Q[n+1] == 1 for its period.
6. Hence, to solve for Eq. 3, we need n to be odd.

Reference:
http://mathworld.wolfram.com/PellEquation.html
"""

def check(res_list):
    bad_list = []
    good_list = []
    for d, (x, y) in res_list.items():
        p1 = x * x - 1
        q1 = d * y * y

        if p1 != q1:
            bad_list.append((d, x, y))
        else:
            good_list.append((d, x, y))

    return good_list, bad_list


UPPER = 1000

tic = time.time()

# Generating D
D = range(UPPER+1)
i2 = 1
i = 1
D[0] = 0
while i2 < len(D):
    D[i2] = 0
    i += 1
    i2 = i ** 2

D_list = [d for d in D[::-1] if d > 0]
res_list = {}
for d in D_list:
    fList = continuedFractionSurd(d)

    N = len(fList)
    if N == 2:
        # special case
        fractionList = fList[:]
    elif N % 2 == 0:
        fractionList = fList[:]
        fractionList.extend(fList[1:-1])
    else:
        fractionList = fList[:-1]

    p, q = expandContinuedFraction(fractionList)

    res_list[d] = (p[-1], q[-1])

toc = time.time()

max_res = max(res_list.items(), key=lambda x: x[1][0])
res = max_res[0]
print "Result = %d, in %f s" % (res, toc - tic)

