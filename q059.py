#!/usr/bin/env python

import time
import random
import re
import string

"""
q059
Note:
1. Information given:
   a. 3 letter key
   b. key in [a-z]
   c. key is repeated cyclically
Algorithm:
1. Define list english_pattern of english word letters together with
   possible punctuation.
2. For each encoded[0::KEY_LEN] find first letter key such that all
   decoded[0::KEY_LEN] are in english_pattern.
3. Repeat step 2 for decoded[1::KEY_LEN] for second letter key, and so on.

Alternate algorithm (without assuming key candidate)
1. Define list english_pattern of english word letters together with
   possible punctuation.
2. Get key[i=0] candidates using key_cand[i=0] = encoded[i=0] ^ each letter in english_pattern.
3. For each candidate of key_cand[i=0],
   a. find decoded[KEY_LEN+0::KEY_LEN] = (key_cand[i=0] ^ encoded[KEY_LEN+0::KEY_LEN]).
   b. if any decoded[KEY_LEN+0::KEY_LEN] not in english_pattern, try next key_cand[i=0]
      and repeat Step 3a and 3b.
   c. Correct key[i=0] is given by key_cand[i=0] such that all decoded[KEY_LEN+0::KEY_LEN] are
      in english_pattern
4. Continue for key[i=1], ..., key[n] by repeating Step 2 to 3 for each key[i].
"""

FILENAME = "q059_data.txt"
KEY_LEN = 3
#KEY_CANDIDATE = string.letters + r"1234567890!@#$%^&*()-=_+,.;:\"'?/"
KEY_CANDIDATE = "abcdefghijklmnopqrstuvwxyz"
english_pattern = r"[a-zA-Z0-9 ,.'\"!?();:]"

with open(FILENAME, "r") as f:
    txt = f.read()
    txt_list = txt.split(",")
    encoded_list = [int(c) for c in txt_list]

tic = time.time()
regex = re.compile(english_pattern)

key_list = [ord(c) for c in KEY_CANDIDATE]
random.shuffle(key_list)
key = [0 for _ in xrange(KEY_LEN)]
decoded_list = list(encoded_list)
for i in xrange(KEY_LEN):
    for j in key_list:
        k = i
        while k < len(encoded_list):
            decoded_list[k] = encoded_list[k] ^ j

            kkk = unichr(decoded_list[k])

            if not regex.match(str(unichr(decoded_list[k]))):
                break

            k += KEY_LEN
        else:
            key[i] = j
            break

res = sum(decoded_list)
toc = time.time()

data_str = "".join([str(unichr(c)) for c in decoded_list])
key_str = "".join([str(unichr(c)) for c in key])

print "Result = %d, in %f s" % (res, toc - tic)