#!/usr/bin/env python

import bisect as bs
import time

from lcc import lcc_math as lm

"""
A perfect number is a number for which the sum of its proper divisors is exactly equal 
to the number. For example, the sum of the proper divisors of 28 would be 
1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

A number n is called deficient if the sum of its proper divisors is less than n and it 
is called abundant if this sum exceeds n.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that 
can be written as the sum of two abundant numbers is 24. By mathematical analysis, it 
can be shown that all integers greater than 28123 can be written as the sum of two 
abundant numbers. However, this upper limit cannot be reduced any further by analysis 
even though it is known that the greatest number that cannot be expressed as the sum of 
two abundant numbers is less than this limit.

Find the sum of all the positive integers which cannot be written as the sum of two 
abundant numbers.
"""
LOWER = 2
UPPER = 28123

perfect = []
deficient = []
abundant = []

for i in range(LOWER, UPPER):
    # -i to take away the number itself, which also exist in the factor set
    sum_prod = sum(lm.prod_factor(i)) - i

    if sum_prod == i:
        perfect.append(i)
    elif sum_prod < i:
        deficient.append(i)
    else:
        abundant.append(i)

# perfect, deficient and abundant lists are sorted

upper_idx = bs.bisect_left(abundant, UPPER / 2.)

abundant_trim = abundant[:upper_idx:]

non_res = []

""" slower
tic = time.time()
for i in range(0, len(abundant_trim)):
    for x in abundant[i::]:
        cand = abundant_trim[i] + x
        if cand > UPPER:
            break
        non_res.append(cand)
toc = time.time()
time1 = toc - tic
"""

tic = time.time()
for i in range(0, len(abundant_trim)):
    non_res.extend([abundant_trim[i] + x for x in abundant[i::] if abundant_trim[i] + x <= UPPER])
toc = time.time()
time2 = toc - tic

non_res_uni = set(non_res)

full_set = set(range(1, UPPER))

res_set = full_set - non_res_uni
res = sum(res_set)

print "Result: %d" % res
