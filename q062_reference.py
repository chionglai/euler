#!/usr/bin/env python

import time

"""
Method #2: From forum
1. Given a range of number, calculate its cube, a3.
2. Apply transformation to a3 such that number with same but permutated digit results in same
   transformation.
3. Use the transformation as dict key.
4. If key does not exist, create new entry. Else increment count, and append number to its entry.
5. Loop till the latest updated count >= N.
"""
tic = time.time()

N = 5
P = range(346, 10000)
i = 0
countDict = {}
resKey = None
for num in P:
    a3 = num ** 3

    a3Str = str(a3)
    digitCount = [0] * 10
    for c in a3Str:
        digitCount[int(c)] += 1

    key = "".join(str(d) for d in digitCount)
    if key in countDict:
        countDict[key][0] += 1
        countDict[key][1].append(num)
    else:
        countDict[key] = [1, [num]]

    if countDict[key][0] >= N:
        resKey = key
        break

toc = time.time()

if resKey is not None:
    resList = countDict[resKey][1]
    res = resList[0] ** 3
    print "Result = %d, in %f s" % (res, toc - tic)
else:
    print "Result not found. Increase upper search limit."
