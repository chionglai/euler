#!/usr/bin/env python

import time
import numpy as np

"""
Algorithm:
Though the actual number is very large, there is no need to calculate the actual value of base ** e. What
is really needed is the relative value for the comparison, that is small enough to be stored, e.g. instead of
calculating base ** e, we can just calculate e * log10(base), and then proceed with normal comparison.
"""

fn = "q099_data.txt"

tic = time.time()

mMax = 0
mIdx = 0
with open(fn, "r") as rd:
    for i, l in enumerate(rd):
        base, e = map(int, l.split(","))
        num = e * np.log10(base)

        if num > mMax:
            mMax = num
            mIdx = i

res = mIdx + 1

toc = time.time()


print "Result = %d, in %f s" % (res, toc - tic)