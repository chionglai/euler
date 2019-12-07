#!/usr/bin/env python
'''
The version of Totient Sum from Problem 72 is same as the version with
sorted(prodFactor) that I have, but it is slower, so it does not make
the cut into my math library. Below is the code.

def totientSum3(n):
    """
    Euler Totient sum function based on implementation from Project
    Euler solution to Problem 72.

    The algorithm is such that:
    1. For a given integer n, having prime factors of p_1, p_2, ..., p_k,
       the Totient Sum is given by,
       (1) phi(n) = n - n/p_1 - n/p_2 + n / (p_1 * p_2) ...
    2. I.e. for a given integer n, if n has k prime factors, let g(k) be
       the partial Totien Sum considered up to k^th prime factor, i.e.
       for g(k = 0) = n
           g(k = 1) = n - n / p_1 = g(0) - g(0) / p_1
           g(k = 2) = n - n / p_1 - n / p_2 + n / (p_1 * p_2)
                    = (n - n / p_1) - (n - n / p_1) / p_2
                    = g(1) - g(1) / p_2
           g(k = 3) = g(2) - g(2) / p_3
           g(k) = g(k - 1) - g(k - 1) / p_k
       which can be calculated recursively.
    3. This algorithm is the same as totient sum version with sorted(prodFactor).

    Args:
        n (int): Argument to Euler Totient sum function.

    Returns:
        int: Result of Euler Totient sum function.
    """
    primes = genPrimeEx(int(m.sqrt(n)))
    primeCount = len(primes)

    g = n
    k = 0
    while k < primeCount:
        p = primes[k]
        if n % p == 0:
            g -= g / p
            while n % p == 0:
                n /= p
        k += 1

    if n > 1:
        g -= g / n

    return g
'''

import time
import math as m
import lcc.lcc_math as lm

limit = 1000000
sieveLimit = (int(m.sqrt(limit)) - 1 ) / 2
maxIndex = (limit - 1) / 2


tic = time.time()

cache = [0] * (maxIndex + 1)
for n in range(1, sieveLimit + 1):
    if cache[n] == 0:
        p = 2*n + 1
        for k in range(2*n*(n+1), maxIndex + 1, p):
            if cache[k] == 0:
                cache[k] = p

multiplier = 1
while multiplier <= limit:
    multiplier *= 2

multiplier /= 2
fractionCount = multiplier - 1
multiplier /= 2
stepIndex = ((limit / multiplier) + 1) / 2

for n in range(1, maxIndex + 1):
    if n == stepIndex:
        multiplier /= 2
        stepIndex = ((limit / multiplier) + 1) / 2

    if cache[n] == 0:
        cache[n] = 2*n
        fractionCount += multiplier * cache[n]
    else:
        p = cache[n]
        cofactor = (2*n + 1) / p
        if cofactor % p == 0:
            factor = p
        else:
            factor = p - 1
        cache[n] = factor * cache[cofactor / 2]
        fractionCount += multiplier * cache[n]

res = fractionCount

toc = time.time()


print "Result = %d, in %f s" % (res, toc - tic)
