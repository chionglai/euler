#!/usr/bin/env python

import time

"""
q063
Note:
1. n-digit equals to a ** n can be mathematically written as:
        floor(log10(a ** n)) + 1 = n    --> Eq.1
2. Rewrite Eq.1 to be:
        log10(a ** n) = n - 1 + eps     --> Eq.2
   where, 0 <= eps < 1, is due to removing floor().
3. Eq.2 results in:
        10 ** (1 - 1/n) <= a < 10, for 0 <= eps < 1     --> Eq.3
4. Since a is integer,
        ceil( 10 ** (1 - 1/n) ) <= a < 10, for 0 <= eps < 1     --> Eq.3a
4. From Eq.3, we can see that as n -> infinity, lower bound == upper bound, i.e. there is no a
   for the given n such that Eq.1 is satisfied.
5. Since a is integer, we can see that the upper limit for the lower bound such that,
   a. Eq.1 is satisfied, and
   b. Eq.3 does not produce empty list for a, will be 9 <= a < 10, i.e. only possible value for a
      will be 9 for this n. Hence,
        10 ** (1 - 1/n) <= 9            --> Eq.4
6. Solving Eq.4 for n gives,
        n <= 1 / (1 - log10 (9))        --> Eq.5
7. Since n is integer,
        n <= floor( 1 / (1 - log10 (9)) )       --> Eq.6

Algorithm:
1. Result = sum( 10 - ceil( 10 ** (1 - 1/n) ) ) for n = [1, floor( 1 / (1 - log10 (9)) )]
"""

# Method 1: Analysis
import math as m
import numpy as np
tic = time.time()
res = sum([10 - m.ceil( 10 ** (1 - 1. / n) ) for n in xrange(1, int(m.floor( 1 / (1 - np.log10(9))) + 1))])
toc = time.time()

print "Result = %d, in %f s" % (res, toc - tic)

# Method 2: To generate list
tic = time.time()

res_list = list()
for n in xrange(1, int(m.floor( 1 / (1 - np.log10(9))) + 1)):
    ll = [(a, n, a ** n) for a in xrange(int(m.ceil( 10 ** (1 - 1. / n))), 10)]
    res_list.extend(ll)

res = len(res_list)

toc = time.time()

print "Result = %d, in %f s" % (res, toc - tic)