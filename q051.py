#!/usr/bin/env python

import itertools as it
import re
import time

from lcc import lcc_math as lm

UPPER = 1000000
MIN_DIGIT = 4
MAX_DIGIT = 6
MIN_SAME_DIGIT = 2
TARGET = 8


tic = time.time()

all_prime = lm.gen_prime(UPPER)

for digit in xrange(MIN_DIGIT, MAX_DIGIT + 1):
    lower = it.ifilter(lambda x: x[1] > 10 ** (digit - 1) - 1, enumerate(all_prime))
    upper = it.ifilter(lambda x: x[1] > 10 ** digit - 1, enumerate(all_prime))

    start_idx = lower.next()[0]
    try:
        end_idx = upper.next()[0]
    except StopIteration:
        end_idx = -1

    prime_str = [str(p) for p in all_prime[start_idx:end_idx:]]

    for i in xrange(digit - 1, MIN_SAME_DIGIT - 1, -1):
        for idx_tup in it.combinations(range(digit), i):
            pattern = "".join([r"(\d)" if i == idx_tup[0] else
                               r"\1"   if len(idx_tup) > 1 and i in idx_tup[1::] else
                               r"\d"       for i in xrange(digit)])
            regex = re.compile(pattern)

            prime_str_trim = [p for p in prime_str if regex.match(p)]

            key_func = lambda x: "".join(["*" if j in idx_tup else c for j, c in enumerate(x)])
            prime_str_trim.sort(key=key_func)
            kg = it.groupby(prime_str_trim, key=key_func)

            for k, g in kg:
                r = list(g)
                if len(r) == TARGET:
                    family = k
                    res = r
                    break
            else:
                continue

            break
        else:
            continue

        break

    else:
        continue

    break

toc = time.time()

print "Result = %s, in %f s" % (res[0], toc - tic)