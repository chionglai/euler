#!/usr/bin/env python

import time
import lcc.lcc_math as lm

"""
Algorithm:
1. Generate a list of totient sum. (Efficiency has been improved
   in lcc_math using sieving method).
2. Sum the list.
"""

N = 1000000

tic = time.time()

totientList = lm.totientSumList(N + 1)
res = sum(totientList)

toc = time.time()

print "Result = %d, in %f s" % (res, toc - tic)
