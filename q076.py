#!/usr/bin/env python

import time
import lcc.lcc_math as lm

"""
This is similar to q031.m
"""

N = 100
setList = range(1, N)

tic = time.time()

y = lm.nCombination(N, setList)
res = sum(y)

toc = time.time()


print "Result = %d, in %f s" % (res, toc - tic)