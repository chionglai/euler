#!/usr/bin/env python

import time
import itertools as it
import operator as op

"""
Algorithm:
1. We have,
         a^2 + b^2 = c^2 (for right triangle) --> Eq.1
   and   p = a + b + c                        --> Eq.2
2. Rewrite c = p - a - b and substitute into Eq.1 results in
         b = p * (p - 2 * a) / ( 2 * (p - a)) --> Eq.3
3. Since, b > 0, hence from Eq.3,
         a < p / 2                            --> Eq.4
4. Furthermore, since the sides a and b can be interchanged,
   for unique (a, b, c), a < b                --> Eq.5
5. Substitute Eq.2 into Eq.4 results in
         a < b + c                            --> Eq.6
6. Comparing Eq.5 and Eq.6, Eq.5 provide a smaller search space.
7. I.e. for a given p, search for a < p/2 such that b (using Eq.3)
   is an integer and a < b.
8. This gives a valid right triangle a and b. c can be obtained
   from Eq.2.
"""

LOWER = 120
UPPER = 1000

tic1 = time.time()
ll = []
for p in xrange(LOWER, UPPER + 1):
    a_list = []
    a = 1
    b = float(p) * (p - 2 * a) / ( 2 * (p - a))
    while a < b:
        if b.is_integer():
            a_list.append((a, b, p - a - b))

        a += 1
        b = float(p) * (p - 2 * a) / ( 2 * (p - a))

    if a_list:
        ll.append(a_list)

max_idx, max_val = max(enumerate(it.imap(len, ll)), key=op.itemgetter(1))
res = sum(ll[max_idx][0])

toc1 = time.time()

for l in ll[max_idx]:
    print l[0] ** 2 + l[1] ** 2 == l[2] ** 2

print "Result = %d, in %f s" % (res, toc1 - tic1)


tic2 = time.time()
ll2 = [[(p, a) for a in xrange(1, p/2) if (float(p) * (p - 2*a) / ( 2 * (p - a))).is_integer()] for p in xrange(LOWER, UPPER + 1) ]
nll2 = list(it.ifilter(None, ll2))

max_idx, max_val = max(enumerate(it.imap(len, nll2)), key=op.itemgetter(1))
res = nll2[max_idx][0][0]

toc2 = time.time()

print "Result = %d, in %f s" % (res, toc2 - tic2)
