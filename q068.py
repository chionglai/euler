#!/usr/bin/env python

import time
import itertools as it
import numpy as np
import lcc.lcc_math as lm


"""

Algorithm:
1. The problem can be written mathematically as
        [A | I] * [x^T | y^T]^T = a * ones         Eq. 1
   where,
   A = I + circshift(I, [0, 1])
   I = Identity matrix
   [x^T | y^T]^T = 1:(N+1), but not in order, is the solution to the problem.
   a = scalar factor
   ones = Vector of all ones

2. Eq. 1 can be rewritten as
        A*x + y = a * ones
              y = (a * ones - A * x)                Eq. 2

3. Finding a that corresponds to a particular selection of y.
   a. First select x from a pool of 1:(N+1). There will be total of nCk combinations.
      E.g. for N = 6, there are total of 20 combinations. For number, n not in x, put them
      in y.
   b. Finding a: a is the sum of the largest number in y and the two smallest number in x.

TODO: find a

4. Solving. For each combination:
   a. Since the system is over-determinate, we need to fix x to find y.
   b. There are multiple possibilities for xk, such that:
        xk = x
        xk[:j] = flipud(xk[:j]), where j = 1, ..., nchoosek(nHalf - 1, 2) (inclusive).
   c. Solve Eq. 2 for each combination and for each xk to get [x^T | y^T]^T by using the
      corresponding xk and a.
   d. Since solution starts with smallest outer number, i.e. from y, and going clockwise, i.e.
      in increasing index, and wrap around, so we need to map non-zero entries in A with xk
      and its corresponding solution y.
   e. Note that, for last index (nHalf - 1), xk needs to be flipped.
"""

N = 10
nHalf = N / 2

tic = time.time()

n = range(1, N + 1)
nSet = set(n)

xComb = it.combinations(n, nHalf)
I = np.identity(nHalf)
A = I + np.roll(I, 1, axis=1)
one = np.array([1] * nHalf).reshape((nHalf, 1))
nFlip = lm.ncr(nHalf-1, 2)

solList = []

for xT in xComb:
    xSet = set(xT)
    ySet = nSet - xSet

    xSorted = sorted(xSet)
    ySorted = sorted(ySet)
    a = xSorted[0] + xSorted[1] + ySorted[-1]

    for j in range(1, nFlip+2):
        xk = np.array(xT).reshape((nHalf, 1))
        xk[:j] = np.flipud(xk[:j])

        yy = a * one - np.matmul(A, xk)
        yy = yy.astype(np.int)

        if ySet == set(yy.flatten()):
            # solution found
            sol = []

            startIdx = np.argmin(yy)
            for i, xIdx, yi in it.islice(it.cycle(zip(it.count(), A, yy)), startIdx, startIdx + nHalf):
                idx = np.where(xIdx)[0]
                if i == nHalf-1:
                    idx = idx[::-1]

                ii = list(it.chain(yi, xk[idx].flatten()))
                sol.append(ii)

            solList.append((a, sol))

intStr = []
for a, l in solList:
    intStr.append(int("".join([str(i) for i in it.chain(*l)])))

res = max(intStr)

toc = time.time()


print "Result = %d, in %f s" % (res, toc - tic)