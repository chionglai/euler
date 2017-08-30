#!/usr/bin/env python

import time
import numpy as np
from lcc.lcc_math import gcd, isSquare, continuedFractionSurd

"""
Algorithm:
1. For a given n, find a_0 = floor( sqrt(n) ).
2. Let remNum = a_0, den = 1
3. For k = 1, ...
   a. Let factor = den
   b. Calculate den = n - remNum^2
   c. Calculate a_n = floor( (a_0 + remNum) * factor / den )
   d. Update remNum = a_n * den - factor * remNum. Need negative of it.
"""
def calcFraction(num):
    # Value of K will affect the correctness of the solution
    K = 11

    a_0 = int(np.floor( np.sqrt(num) ))
    remNum = a_0
    den = 1

    isPeriodic = False
    periodList = []
    subList = []
    subIdx = 0
    repeatCount = 0
    while not isPeriodic:
        factor = den
        den = num - remNum ** 2
        c = gcd(factor, den)

        factor /= c
        den /= c
        a_n = np.floor( (a_0 + remNum) * factor / den )
        remNum = a_n * den - factor * remNum

        subList.append(int(a_n))
        plLen = len(periodList)
        slLen = len(subList)

        if plLen == 0 or (slLen < plLen and subList != periodList[:slLen]):
            periodList.extend(subList)
            subList = []
            subIdx = 0
            repeatCount = 0

        if plLen > 0 and slLen % plLen == 0:
            # For len(subList) > len(periodList)
            # Wait till K repetition before deciding it is periodic
            if subList[subIdx:subIdx+plLen] == periodList:
                subIdx += plLen
                repeatCount += 1
                if repeatCount*plLen >= K:
                    isPeriodic = True
            else:
                # if not periodic yet, append subList to periodList. Reset subList
                periodList.extend(subList)
                subList = []
                subIdx = 0
                repeatCount = 0

    return a_0, periodList


tic = time.time()

N = 10000
resList = {}
oddCount = 0
for num in range(2, N+1):
    if not isSquare(num):
        periodList = continuedFractionSurd(num)
        if (len(periodList) - 1) % 2 == 1:
            oddCount += 1
        resList[num] = periodList

toc = time.time()

res = oddCount

print "Result = %d, in %f s" % (res, toc - tic)