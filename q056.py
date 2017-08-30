#!/usr/bin/env python

import time

LOWER = 2
UPPER = 99
COUNT_THRESH = 100

tic = time.time()

max_sum = 0
for a in xrange(UPPER, LOWER - 1, -1):
    for b in xrange(UPPER, LOWER - 1, -1):
        sum_digit = sum([int(d) for d in str(a ** b)])
        max_sum = sum_digit if sum_digit > max_sum else max_sum

toc = time.time()

res = max_sum
print "Result = %d, in %f s" % (res, toc - tic)



# Heuristic method: Plot, observe and limit search space. No theoretical proof.
tic = time.time()

max_sum = 0
max_a = 0
max_b = 0
num = []
count = 0

for a in xrange(UPPER, LOWER - 1, -1):
    for b in xrange(UPPER, LOWER - 1, -1):
        sum_digit = sum([int(d) for d in str(a ** b)])

        # to get more result
        num.append(sum_digit)
        if sum_digit > max_sum:
            max_sum = sum_digit
            max_a = a
            max_b = b
            count = 0
        elif count > COUNT_THRESH:
            break
        else:
            count += 1
    else:
        continue

    break

toc = time.time()

res = max_sum
print "Result = %d, in %f s" % (res, toc - tic)