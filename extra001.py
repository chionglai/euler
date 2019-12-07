#!/usr/bin/env python

import time

"""
Question:

  a       b       c
----- + ----- + ----- = 4, for a, b, c > 0 and integer
b + c   a + c   a + b

Find smallest a, b, c that satisfy the above equation.
"""

N = 10000

tic = time.time()

for c in range(2, N):
    for b in range(1, c):
        for a in range(0, b):
            aPlusB = a + b
            aPlusC = a + c
            bPlusC = b + c

            if (a * aPlusB * aPlusC + b * bPlusC * aPlusB + c * bPlusC * aPlusC) == 4 * aPlusB * aPlusC * bPlusC:
                break

toc = time.time()

print "Result: a = %d, b = %d, c = %d, in %f s" % (a, b, c, toc - tic)
