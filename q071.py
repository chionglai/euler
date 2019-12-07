#!/usr/bin/env python

import time

"""
Algorithm:
There is a pattern here. The explanation will be based on the
example given in the problem. We want to find what is numerator
of the proper fraction directly left to 3/7. Notice that from
the example given, the fraction left to 3/7 is 2/5, i.e.

..., 2/5, 3/7, ...

As d is increased, new proper fraction added to the left of
3/7 will be in the following pattern

a^(num)_1 + d^(num) * n
-----------------------
a^(den)_1 + d^(den) * n

Let's call the 3/7 the pivot. Hence, from the problem given,
a^(num)_1 and a^(num)_1 is the numerator and denominator
directly left to the pivot. d^(num) and d^(den) is the
numerator and denominator of the pivot. Then, the algorithm,
which is O(1) in both memory and computational, will be:
1. Solve a^(den)_1 + d^(den) * n <= d for n.
2. Use the n obtained in 1 to calculate for
   a^(num)_1 + d^(num) * n
"""

d = 1e6
d_num = 3
d_den = 7
a_num_1 = 2
a_den_1 = 5

tic = time.time()

n = (d - a_den_1) // d_den

numerator = a_num_1 + d_num * n

res = numerator
toc = time.time()

denominator = a_den_1 + d_den * n

print "Result = %d, in %f s" % (res, toc - tic)
print "The fraction is %d / %d" % (numerator, denominator)
