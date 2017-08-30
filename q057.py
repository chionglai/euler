#!/usr/bin/env python

import time

"""
q057
A. My method
i = 1: num = 3, den = 2
i = 2: num = 7, den = 5
i = 3: num = 17 = 2 * num[i-1] + num[i-2], den = 12 = 2 * den[i-1] + den[i-2]
...

B. Other people method
i = 1: num = 3, den = 2
i = 2: num = 2 * den[i-1] + num[i-1], den = num[i-1] + den[i-1]
...
"""

UPPER = 1001

tic = time.time()

buf_num = [3, 7]
buf_den = [2, 5]
count = 0

for _ in xrange(3, UPPER):
    new_num = buf_num[1] * 2 + buf_num[0]
    new_den = buf_den[1] * 2 + buf_den[0]

    if len(str(new_num)) > len(str(new_den)):
        count += 1

    buf_num = [buf_num[1], new_num]
    buf_den = [buf_den[1], new_den]

toc = time.time()

res = count
print "Result = %d, in %f s" % (res, toc - tic)