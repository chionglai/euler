#!/usr/bin/env python

import time
import numpy as np

"""
Take the number 192 and multiply it by each of 1, 2, and 3:

192 x 1 = 192
192 x 2 = 384
192 x 3 = 576
By concatenating each product we get the 1 to 9 pandigital, 192384576.
We will call 192384576 the concatenated product of 192 and (1,2,3)

The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4,
and 5, giving the pandigital, 918273645, which is the concatenated product
of 9 and (1,2,3,4,5).

What is the largest 1 to 9 pandigital 9-digit number that can be formed as
the concatenated product of an integer with (1,2, ... , n) where n > 1?

Algorithm:
1. Denotes a as the 'an integer'. Hence, for n = 2, ..., UPPER_N, the
   following conditions must hold:
   a. a must contain unique digits
   b. 10 ** (9. / n - 1) <= a <= (10 ** (9. / n) ) /n
2. For n = 2 to UPPER_N, construct a list of candidate a using condition 1.a and 1.b
3. For each a,
   a. Find product of nn = 1 to n with a
   b. Concatat the product
   c. Test the concat to see if it is pandigital
"""

DIGITS = "123456789"
UPPER_N = 9

tic = time.time()

aRes = []
pRes = []
for n in range(2, UPPER_N + 1):
    aLower = int( 10 ** (9. / n - 1) + 0.5 )
    aUpper = int( ( 10 ** (9. / n) ) / n + 0.5)

    # Construct the candidate for a. Removing value of a with non-unique digits
    aList = [x for x in range(aUpper, aLower, -1) if len(str(x)) == len(set(str(x)))]

    nn = np.array(range(1, n + 1))
    for a in aList:
        prod = a * nn

        prodStrList = [str(p) for p in prod]
        prodStr = ''.join(prodStrList)

        if len(prodStr) == len(DIGITS) and all(x in prodStr for x in DIGITS):
            aRes.append(a)
            pRes.append(prodStr)

pRes.sort(reverse=True)
toc = time.time()

print "Result = %s, in % s\n" % (pRes[0], toc - tic)
