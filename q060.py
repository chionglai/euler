#!/usr/bin/env python

import time

import numpy as np

from lcc import lcc_math as lm

"""
q060
Algorithm (by iwek7, from forum):
1. Generate prime list up to N. Remove 2 and 5 from list since they are trivial.
   Call the list prime_list.
2. Create an empty list all_list, to contain lists of prime pairs.
3. For each prime, ci, in prime_list, do
   a. create an empty new_list to contain newly found lists of prime pairs
   b. for each list l in all_list, do
      i. Test if ALL primes in l form prime pair with ci.
      ii. If it does,
          1. Create a copy of list l, call it cl
          2. Append ci to this cl
          3. If length of cl >= LEN, solution found.
          4. Append cl to new_list
   c. Append all lists in new_list to all_list
   d. Append [ci] to all_list

Optimisation:
1. Create a is_prime_table to store the flag if a given prime pairs are prime or not. This
   is to avoid primality test for a given prime pair.
2. Use a faster prime generation algorithm.
3. Use a faster primality test algorithm, rather than generating list of primes and test
   if a prime pair is in the list or not.
"""

UPPER = 10000
LEN = 5

tic = time.time()

prime_cand = lm.gen_prime(UPPER)
prime_cand.remove(2)
prime_cand.remove(5)
prime_len = len(prime_cand)

res_list = []
is_prime_table = np.zeros((prime_len, prime_len))


def test_cat(prime_set, ci, i, lut):
    for j, cj in prime_set:
        if lut[i][j] == 0:
            cat1 = int(str(ci) + str(cj))
            cat2 = int(str(cj) + str(ci))

            is_prime = lm.is_prime(cat1) and lm.is_prime(cat2)

            lut[i][j] = 1 if is_prime else -1
            lut[j][i] = 1 if is_prime else -1

        if lut[i][j] == -1:
            return False

    return True


def solve_q060(prime, LEN):
    all_list = list()
    for i, ci in enumerate(prime):
        new_list = list()

        for l in all_list:
            if test_cat(l, ci, i, is_prime_table):
                new_cand = list(l)
                new_cand.append((i, ci))

                if len(new_cand) >= LEN:
                    return new_cand

                new_list.append(new_cand)

        all_list.extend(new_list)
        all_list.append([(i, ci)])

    return None

res_list = solve_q060(prime_cand, LEN)
res_list = [c[1] for c in res_list]
toc = time.time()

if res_list:
    res = sum(res_list)
    print "Result = %d, in %f s" % (res, toc - tic)
else:
    print "Not found, try increase prime numbers."
