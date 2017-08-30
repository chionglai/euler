#!/usr/bin/env python

import time
import numpy as np
import itertools as it

"""
Note:
1. Given a polygonal function p(k, n), and only 4-digit numbers are asked for.

Algorithm:
1. Find the range of integer n for each polygon k, such that its polygonal number is 4 digit.
2. From the range found in Step 1, calculate all the 4-digit polygonal numbers for each k.
3. Permute the list.
3. Starting from the list with least number of 4-digit polygonal numbers, filter to find the set.

To find the range of n, we need 3 <= log10( p(k, n) ) < 4. Using Matlab, for
k = 3, 45 <= n < 140
k = 4, 32 <= n < 100
k = 5, 26 <= n < 81
k = 6, 23 <= n < 70
k = 7, 21 <= n < 63
k = 8, 19 <= n < 58

The above are the range of integer n that produces 4-digit polygonal number. It forms the search area.
"""

def p3(n):
    return n * (n + 1) / 2

def p4(n):
    return n ** 2

def p5(n):
    return n * (3*n - 1) / 2

def p6(n):
    return n * (2*n - 1)

def p7(n):
    return n * (5*n - 3) / 2

def p8(n):
    return n * (3*n - 2)


def recurseSearch(res, candList, level):
    """
    Search and filter using recursion.
    Args:
        res: List containing up to current level result candidate.
        candList: Whole 4-digit polygonal numbers.
        level: Current search and filter level.

    Returns:
        True if solution found, False otherwise.
    """
    if level == 0:
        # last level, no need to do tree search. Just concatenate two ends anc search
        # if the number exists in the list
        num = (res[-1] % 100) * 100 + res[0] / 100
        status = num in candList[level]
        if status:
            res.insert(0, num)
        return status
    else:
        for num in candList[level]:
            if num % 100 == res[0] / 100:
                # continue searching
                res.insert(0, num)
                status = recurseSearch(res, candList, level - 1)
                if status:
                    return True
                else:
                    res.pop(0)
        return False

edge = [(45, 140),
        (32, 100),
        (26, 81),
        (23, 70),
        (21, 63),
        (19, 58)
        ]

pk = [p3, p4, p5, p6, p7, p8]

tic = time.time()

# 2. calculate all 4-digit polygonal numbers
candList = []
for i, (s, e) in enumerate(edge):
    vpk = np.vectorize(pk[i])
    candList.append(vpk(range(s, e)))

# 3. filter from p8 to p3, since p8 has the shortest list of candidates. Need recursion.
idx = len(edge) - 1
for permCandList in it.permutations(candList):
    res = []
    for num in permCandList[idx]:
        res.insert(0, num)
        status = recurseSearch(res, permCandList, idx - 1)

        if status:
            break
        else:
            res.pop(0)
    else:
        continue
    break

toc = time.time()

print "Result = %s, in %f s" % (str(res), toc - tic)
