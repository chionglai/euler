#!/usr/bin/env python

import numpy as np
import time

"""
Analysis to reduce the search space:
1. Let N be the number of permutations.
2. Let a_0 be the first candidate for the N permutation such that a_n for n = 1, ..., N-1 form the solution.
3. Let P be the search space such that a_n in P for all n = 0, ..., N-1.
4. Hence, for a given a_0, the range or search space for the remaining a_n for n = 1, ..., N-1 can be
   determined by
        numDigit = ceil( log10(a_0^3) ) = ceil( log10(a_n^3) )
                   3*log10(a_n) + eps1 = 3*log10(a_0) + eps0    , where 0 <= eps0 < 1, 0 <= eps1 < 1 are
                                                                  added to remove the ceil(.)
             a_n = a_0 * 10^( (eps0 - eps1)/3 )         -- Eq. 1
5. Since 0 <= eps1 < 1, and for a given a_0, eps0 can be determined from
        eps0 = ceil( 3*log10(a_0) ) - 3*log10(a_0),     -- Eq. 2
   we have,
        (eps0 - 1)/3 < (eps0 - eps1)/3 <= eps0/3        -- Eq. 3
6. This gives the range/search space P_n of a_n for n = 1, ..., N-1, and for a given a_0 to be
        P_n = [ceil( a_0*10^( (eps0 - 1)/3 ) ), floor( a_0*10^(eps0/3) )]       -- Eq. 4
7. However, since a_0 is iterated/searched in increasing order, i.e. a_0 is the smallest cube candidate,
   P_n can be further reduced to
        P_n = (a_0, floor( a_0*10^(eps0/3) )]           -- Eq. 5
   Likewise, if a_0 is iterated in decreasing order, i.e. a_0 is the largest cube candidate, P_n can be
   reduced to
        P_n = [ceil( a_0*10^( (eps0 - 1)/3 ) ), a_0]

Algorithm:
1. Initialise P = [346, upperLimit].
2. Let i = 0.
3. WHILE i < len(P) AND solution list length != N DO
        Let a_0 = P[i] and calculate a_0p3 = a_0^3
        Let solution list be a_0
        Convert a_0p3 to str and sort its digit.
        Calculate P_n using Eq. 2 and Eq. 5
        FOR each P_n DO
            Calculate a_np3 = a_n^3
            Convert a_np3 to str and sort its digit.
            IF a_np3 == a_0p3
                Add a_n to solution list
            ENDIF
        ENDFOR
   ENDWHILE
4. Solution is the solution list if P has not been exhausted.
"""

tic = time.time()

N = 5
P = range(5000, 5050)
i = 0
res = []
while i < len(P) and len(res) != N:
    a_0 = P[i]
    i += 1
    res = [a_0]
    a_0p3 = a_0 ** 3
    a_0p3Str = sorted(str(a_0p3))

    eps0 = np.ceil( 3*np.log10(a_0) ) - 3*np.log10(a_0)
    P_n = range(a_0 + 1, int(np.floor( a_0 * (10 ** (eps0/3) ))))
    for a_n in P_n:
        a_np3 = a_n ** 3
        a_np3Str = sorted(str(a_np3))
        if a_np3Str == a_0p3Str:
            res.append(a_n)
# Must not remove
        # elif a_n in P:
        #     # remove from a_0 search space
        #     P.remove(a_n)

toc = time.time()

print res
print "Result = %d, in %f s" % (res[0], toc - tic)

