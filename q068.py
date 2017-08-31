#!/usr/bin/env python

import time
import itertools as it
import numpy as np
import lcc.lcc_math as lm


"""

Algorithm:
1. The problem can be written mathematically as
        x(1) + x(N/2 + 1) + x(N/2 + 2) = a
        x(2) + x(N/2 + 2) + x(N/2 + 3) = a
        ...
        x(N/2) + x(N/2 + 1) + x(N)     = a

   which is an under-determinate system and can be rearrange to
        -a              + x(N/2 + 2) = -x(1) - x(N/2 + 1)
        -a + x(N/2 + 2) + x(N/2 + 3) = -x(2)
        -a + x(N/2 + 3) + x(N/2 + 4) = -x(3)
         ...
        -a + x(N)                    = -x(N/2) - x(N/2 + 1)
   and can be written as:
        A*x = -y - xi           Eq. 1
   where
   A = [-1, 1, 0, 0, 0, ...]
       [-1, 1, 1, 0, 0, ...]
       [-1, 0, 1, 1, 0, ...]
       [-1, 0, 0, 1, 1, ...]
       [-1, 0, 0, 0, 1, ...]
   x = [a; x(N/2 + 2); ...; x(N)]
   y = [x(1); x(2); ...; x(N/2)]
   xi = [x(N/2 + 1); 0; ...; 0; x(N/2 + 1)]
2. Because this is an under-determinate system, we need to fixed x(1) to x(N/2+1),
   and there will be multiple solution. This will be the search space.
3. First, we need to permute all possible combination for [x(1), ..., x(N/2)]. Then,
   because the magin N-gon ring is circular symmetric, any circular shift of
   [x(1), ..., x(N/2)] is non-unique and can be removed from the search space.
4. Once non-unique combinations are removed, we can proceed to solve the problem. For each
   unique combination [x(1), ..., x(N/2)]:
   a. we have the corresponding set [x(N/2+1), ..., x(N)].
   b. For each value in [x(N/2+1), ..., x(N)], fix x(N/2+1), and solve Eq.1 for x.
   c. Solution is found when all [x(N/2+1), ..., x(N)] from solving Eq.1 is in the set
      [x(N/2+1), ..., x(N)]
"""

# This only works for N = 10
N = 10
nHalf = N / 2

A = np.zeros((nHalf, nHalf))
A[:, 0] = [-1] * nHalf
for i in range(1, nHalf):
    A[i-1:i+1, i] = [1] * 2

Ainv = np.linalg.inv(A)
v = np.zeros((nHalf, 1))
v[0] = 1
v[-1] = 1

tic = time.time()

n = range(1, N + 1)
yComb = list(it.permutations(n, nHalf))

# sort and circshift
for i in range(len(yComb)):
    val, idx = min((val, idx) for idx, val in enumerate(yComb[i]))
    yComb[i] = list(np.roll(yComb[i], -idx))

# remove repeats
yCombUnique = set(map(tuple, yComb))

sol = []
nSet = set(n)
for y in yCombUnique:
    # ySet corresponds to outer node
    # xSet corresponds to inner node
    ySet = set(y)
    xSet = nSet - ySet

    for xi in xSet:
        xx = np.matmul(Ainv, -np.reshape(np.array(y), (nHalf, 1)) - v * xi)

        xCand = [xi]
        xCand.extend(xx[1:, 0])
        a = xx[0, 0]

        if set(tuple(xCand)) == xSet:
            # solution found, so collect the solution
            xCandI = list(it.chain(xCand, xCand))
            yx = [(yk, xCandI[i], xCandI[i+1]) for i, yk in enumerate(y)]
            sol.append((yx, a))

# sorting
solCat = []
for s in sol:
    yx, a = s
    sum = ""
    for v in it.chain(*yx):
        sum += str(int(v))
    solCat.append((sum, a))

solCat = sorted(solCat, key=lambda x: int(x[0]))

res = solCat[-1][0]

toc = time.time()

print "Result = %s, in %f s" % (res, toc - tic)