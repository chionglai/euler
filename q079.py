#!/usr/bin/env python

import time
import lcc.lcc_math as lm

"""
Algorithm:
1. Read a line from file.
2. For each digit, check if they already in solution list or not.
   a. If it is, log the number of digit before it that are not in the solution list.
      This is to allow us to add them to the right position (relative to it) in the
      solution list.
3. If 2 or more digits already exist in the solution list, then we need to perform
   sorting and rearranging. The rearranging involve swapping:
   a. the actual digit in solution list
   b. only the index in the inList (temporary list)
   Bubble sort works great in this context.
4. After sorting, we need to add the new digits (not in solution list) to the left or
   right of the digit already in the solution list.
"""

N = 3
fn = "q079_data.txt"

tic = time.time()

sol = []
with open(fn, "r") as rd:
    for l in rd:
        dig = lm.extract_digit(int(l))

        inList = []
        nNone = 0
        for i, d in enumerate(dig):
            if d in sol:
                inList.append([d, sol.index(d), nNone])
                nNone = 0
            else:
                nNone += 1

        nInList = len(inList)
        if nInList >= 2:
            # do reorder. Use bubble sort since it is simple
            for i in range(nInList - 1):
                for j in range(i+1, nInList):
                    if inList[i][1] > inList[j][1]:
                        # swap in sol
                        temp = sol[inList[i][1]]
                        sol[inList[i][1]] = sol[inList[j][1]]
                        sol[inList[j][1]] = temp

                        # swap only index in inList
                        temp = inList[i][1]
                        inList[i][1] = inList[j][1]
                        inList[j][1] = temp

        # find starting index
        idx = 0
        for idx, v in enumerate(inList):
            if v[2] != 0:
                break

        # add new entry
        for _, i, n in inList:
            if n > 0:
                # insert to the front of i
                sol[i:i] = dig[idx:idx+n]
                idx += n

        nLeft = len(dig) - len(inList)
        if idx < nLeft:
            # append to the end of sol
            sol.extend(dig[idx:nLeft])


res = lm.combine_digit(sol)

toc = time.time()


print "Result = %d, in %f s" % (res, toc - tic)