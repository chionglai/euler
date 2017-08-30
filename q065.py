#!/usr/bin/env python

import itertools as it
import time

import numpy as np

from lcc import lcc_math as lm

"""
Problem:
Given, e.g. sqrt(23), get a sequence [4; (1, 3, 1, 8)]

Algorithm:
To find the sequence (may not be optimised, but straightforward). But, this depends on the accuracy
of the floating point representation of the number:
1. Given sqrt(k), calculate the square root of k, in float, call it floatRes.
2. Round floatRes down to nearest integer, call it intRes.
3. Append intRes to list.
4. Calculate floatRes = 1 / (floatRes - intRes).
5. Reapeat from Step 2.
"""

def findSeq(val, length):
    res = []
    floatRes = val
    for _ in range(length):
        intRes = int(floatRes)
        floatRes = 1. / (floatRes - intRes)
        res.append(intRes)
    return res

def findSeqE():
    n = 2
    yield n
    while True:
        yield 1
        yield n
        yield 1
        n += 2


val = np.exp(1)
N = 100

tic = time.time()

seq = list(it.islice(findSeqE(), N))

num = seq[-1]
den = 1
for i in seq[-2::-1]:
    # flip
    temp = num
    num = den
    den = temp

    num += i * den

res = lm.sumDigit(num)

toc = time.time()


print "Result = %d, in %f s" % (res, toc - tic)