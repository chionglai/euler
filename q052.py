#!/usr/bin/env python

import time
import itertools as it

"""
q052
It can be seen that the number, 125874, and its double, 251748,
contain exactly the same digits, but in a different order.

Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x,
and 6x, contain the same digits.

Algorithm:
1. Since the digits need to be the same up to 6x, the following
   conditions can be used to reduce search space:
   a. Left-most digit must be 1
   b. Second digit from left must be 2 to 6 inclusive
   c. The rest is permutation of remaining digits
   d. This results (and assumes) search space starts with 3-digit value.
2. Construct candidates x using conditions from step 1.
3. Test all product of 2*x, ..., 6*x contain same digits.
"""

# digit 1 must be the MSB digit
DIGIT = range(2, 10)
N_LOWER = 2
N_UPPER = 6

tic = time.time()

# 2nd MSB digit is between 2 to 6
MSB_2 = range(2, 7)

res = []
for msb2 in MSB_2:
    # remaining digits excluding '1' and second digit from left
    remDigit = list(DIGIT)
    remDigit.remove(msb2)

    # perform permutation of 1 to length of remaining digits
    for i in range(1, len(remDigit)):
        # permute the digits to get candidate x
        digitList = list(it.permutations(remDigit, i))

        for dTuple in digitList:
            # for each permutation
            digit = list(dTuple)
            digit.insert(0, 1)
            digit.insert(1, msb2)

            # convert str to int
            x = reduce(lambda r, d: r * 10 + d, digit)

            for n in range(N_LOWER, N_UPPER + 1):
                nx = n * x

                # convert int to str
                nxDigit = [int(d) for d in str(nx)]

                # violates the condition, break
                if len(nxDigit) != len(digit) or not all(x in nxDigit for x in digit):
                    break
            else:
                # no violation, result found
                res.append(x)

toc = time.time()
print "Result = %d, in %f s\n" % (res[0], toc - tic)