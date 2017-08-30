#!/usr/bin/env python

import time
import itertools as it

"""
q032:
We shall say that an n-digit number is pandigital if it makes use of all the digits 1
to n exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand,
multiplier, and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written
as a 1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it
once in your sum.

Algorithm:
1. Given a * b = c, where a, b, c must contain all digits 1-9
2. Hence, a = 9 permutate i, and b = (9-i) permutate j
3. Since i + j < 9 digits - i - j + 1 --> i + j < 5, (i, j) = (1, 4), (2, 3), ...

"""

DIGIT = range(1, 10)
MAX_DIGIT_FACTOR = 4

aRes = []
bRes = []
cRes = []

tic = time.time()

# for i = 1 to 4
for i in range(MAX_DIGIT_FACTOR, 0, -1):
    # get all permutation for a
    aList = list(it.permutations(DIGIT, i))

    # for each permutation of a
    for aSub in aList:
        # remove digits already in a
        bDigit = [d for d in DIGIT if d not in aSub]

        # convert a to int
        a = reduce(lambda r, d: r * 10 + d, aSub)

        # for j = 4 to 1
        for j in range(1, MAX_DIGIT_FACTOR - i + 2):
            # get all permutation for b
            bList = list(it.permutations(bDigit, j))

            # for each permutation of b
            for bSub in bList:
                # remDigit will always in ascending order
                remDigit = [d for d in bDigit if d not in bSub]

                b = reduce(lambda r, d: r * 10 + d, bSub)

                product = a * b
                prodList = [int(digit) for digit in str(product)]

                # product found iff
                # 1. length of (a * b) == length(remDigit)
                # 2. all digit in remDigit in (a * b)
                if len(prodList) == len(remDigit) and all(x in prodList for x in remDigit):
                    aRes.append(a)
                    bRes.append(b)
                    cRes.append(product)

res = sum(set(cRes))
toc = time.time()

print "Result = %d, in %f s" % (res, toc - tic)

# (Optional) remove non-unique product
aUni = []
bUni = []
cUni = []
for i, c in enumerate(cRes):
    if c not in cUni:
        aUni.append(aRes[i])
        bUni.append(bRes[i])
        cUni.append(c)
