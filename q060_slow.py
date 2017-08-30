def test_cat(num1, num2, lut, i, j):
    entry = lut[i][j]
    if entry == 1:
        return True
    elif entry == -1:
        return False
    else:
        cat1 = int(str(num1) + str(num2))
        cat2 = int(str(num2) + str(num1))

        is_prime = lm.is_prime(cat1) and lm.is_prime(cat2)

        lut[i][j] = 1 if is_prime else -1
        lut[j][i] = 1 if is_prime else -1

        return is_prime


UPPER = 10000
LEN = 5

tic = time.time()

prime_cand = lm.gen_prime(UPPER)
prime_cand.remove(2)
prime_cand.remove(5)

prime_len = len(prime_cand)

res_list = []

is_prime_table = np.zeros((prime_len, prime_len))

i = 0
len_loop = len(prime_cand) - LEN
cand_ll = []
while i < len_loop:
    ci = prime_cand[i]

    for jj, cj in enumerate(prime_cand[i + 1::]):
        j = jj + i + 1
        if test_cat(ci, cj, is_prime_table, i, j):

            l_idx = xrange(len(cand_ll))
            for li in l_idx:
                l = cand_ll[li]
                tt = [1 for k, ck in l if test_cat(cj, ck, is_prime_table, j, k)]
                if sum(tt) == len(l):
                    new_list = list(l)
                    new_list.append((j, cj))
                    if len(new_list) >= (LEN - 1):
                        rl = list(new_list)
                        rl.insert(0, (i, ci))
                        res_list.append(rl)

                    cand_ll.append(new_list)

            cand_ll.append([(j, cj)])

    cand_ll = []
    i += 1

toc = time.time()

if res_list:
    sum_list = [sum([c for i, c in l]) for l in res_list]

    res = min(sum_list)
    print "Result = %d, in %f s" % (res, toc - tic)
else:
    print "Not found, try increase prime numbers."
