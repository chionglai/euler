#!/usr/bin/env python

import time

from lcc import lcc_math as lm

"""
q058

Algorithm:
1. The values for each corner at layer side_len is
      side_len ** 2 - [3, 2, 1, 0] * (side_len - 1)
2. For each value, test for primality and increment prime counter (if prime).
3. Calculate new ratio for each layer
"""

TARGET = 10. /100

# Method 2 (using is_prime() from somewhere): only test for primality
tic = time.time()

corner = [3, 2, 1]
side_len = 3
total = 5.
count = 3
ratio = count / total

while ratio > TARGET:
    side_len += 2
    total += 4

    # Corner number is side_len ^ 2 - [0, 1, 2, 3] * (side_len - 1)
    num = [side_len ** 2 - i * (side_len - 1) for i in corner]

    c = [1 for n in num if lm.is_prime(n)]
    count += sum(c)

    ratio = count / total


res = side_len

toc = time.time()

print "Result = %d, in %f s" % (res, toc - tic)


# Method 1 (my original): generate list of prime for primality test
"""
import bisect as bs
import itertools as it
import numpy as np

MAX_PRIME = 900000000
prime_file = "prime2.npz"

tic = time.time()

data = np.load(prime_file)
prime = data["prime"]
len_prime = len(prime)

corner = [3, 2, 1]

side_len = 3
total = 5.
count = 3
ratio = count / total

prime_gen = enumerate(prime)
gt_func = lambda x: x[1] > num_i
next_gt_gen = it.ifilter(gt_func, prime_gen)
start_search_idx = 0
while ratio > TARGET:
    side_len += 2
    total += 4

    # Corner number is side_len ^ 2 - [0, 1, 2, 3] * (side_len - 1)
    num = [side_len ** 2 - i * (side_len - 1) for i in corner]

    # count how many prime in the corners
    for n in num:
        num_i = n

        # since prime list is sorted in ascending order, only need to do a bi-section
        # search for part of the list (to speed up) where
        #   start_search_idx = previous end_search_idx
        #   end_search_idx = first index where prime > value
        end_search_idx = next_gt_gen.next()[0]
        i = bs.bisect_left(prime[start_search_idx:end_search_idx:], n)
        if i != len_prime and prime[i + start_search_idx] == n:
            count += 1

        start_search_idx = end_search_idx

    ratio = count / total

if num[0] > prime[-1]:
    print "Prime list not big enough. Increase MAX_PRIME."

res = side_len

toc = time.time()

print "Result = %d, in %f s" % (res, toc - tic)

"""