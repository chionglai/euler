#!/usr/bin/env python

import time
import lcc.file as lf

"""
Algorithm:
1. Given a matrix:
    [a0, a1, a2, ..., aN]
    [b0, b1, b2, ..., bN]
    [c0, c1, c2, ..., cN]
    [...]
    [M0, M1, M2, ..., MN]
2. First cumulatively add first row, such that
    [a0, a0+a1, a0+a1+a2, ..., a0+a1+...+aN]
    [b0, b1, b2, ..., bN]
    [c0, c1, c2, ..., cN]
    [...]
    [M0, M1, M2, ..., MN]
3. Then cumulatively add first column, such that
    [a0,           a0+a1, a0+a1+a2, ..., a0+a1+...+aN]
    [a0+b0,        b1, b2, ..., bN]
    [a0+b0+c0,     c1, c2, ..., cN]
    [...]
    [a0+b0+...+M0, M1, M2, ..., MN]
4. Selectively cummulatively add the remaining, starting from matrix[1][1].
5. The solution is given by matrix[-1][-1]
"""


fn = "q081_data.txt"
matrix = lf.readMatrixFromText(fn)

# Example
# import numpy as np
# matrix = np.array([[131, 673, 234, 103, 18],
#                    [201, 96, 342, 965, 150],
#                    [630, 803, 746, 422, 111],
#                    [537, 699, 497, 121, 956],
#                    [805, 732, 524, 37, 331] ])

tic = time.time()

nRow, nCol = matrix.shape

# Simply cumulatively add first column
for i in range(1, nRow):
    matrix[i][0] += matrix[i-1][0]

# Simply cumulatively add first row
for j in range(1, nCol):
    matrix[0][j] += matrix[0][j-1]

# decide to add from left or top element
for i in range(1, nRow):
    for j in range(1, nCol):
        if matrix[i][j-1] < matrix[i-1][j]:
            matrix[i][j] += matrix[i][j-1]
        else:
            matrix[i][j] += matrix[i-1][j]

res = matrix[-1][-1]

toc = time.time()


print "Result = %d, in %f s" % (res, toc - tic)