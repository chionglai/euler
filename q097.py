#!/usr/bin/env python

import time

a = 28433
e = 7830457
m = 10 ** 10

tic = time.time()

num = a * 2 ** e + 1

res = int(num % m)

"""
Method #2
Using modular operation, since we are only interested in the first 10 digit. So, the remaining digit
can be ignored using modulo operation.
"""

step = 64
c = 1
b = 2 ** step
for k in range(e / step):
    c = (b * c) % m

d = 2 ** (e - (k + 1) * step)

res = (c * a * d + 1) % m

toc = time.time()


print "Result = %d, in %f s" % (res, toc - tic)