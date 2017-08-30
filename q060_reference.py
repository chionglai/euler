import datetime
t0 = datetime.datetime.now().replace(microsecond=0)

SIZE_THRESHOLD = 5

# create list of primes to check with sieve
# http://stackoverflow.com/questions/2068372/fastest-way-to-list-all-primes-below-n
def rwh_primes(n):
    """ Returns  a list of primes < n """
    sieve = [True] * n
    for i in range(3,int(n**0.5)+1,2):
        if sieve[i]:
            sieve[i*i::2*i]=[False]*int(((n-i*i-1)/(2*i)+1))
    return [2] + [i for i in range(3,n,2) if sieve[i]]

ALL_PRIMES = rwh_primes(400000000)
# turn this into set for faster lookups
ALL_PRIMES_SET = set(ALL_PRIMES)

# check is condition from task is fullfiled
def check_property(existing_primes_set, new_prime):
    for prime in existing_primes_set:
        if (int(str(prime) + str(new_prime)) not in ALL_PRIMES_SET or
             int(str(new_prime) + str(prime)) not in ALL_PRIMES_SET):
                return False
    return True

def compute_solution():
    all_prime_sets = list()
    # for each prime check if it matches any of existing sets
    # if yes prepare copy of this set with prime and add it to prime sets
    # leave existing sets unchanged (do coping of existing set not assigment)
    # at the end of the loop add prime alone to list of sets
    for prime in ALL_PRIMES:
        # create temporary list of new sets
        new_prime_sets = list()
        for prime_set in all_prime_sets:
            if check_property(prime_set,prime):
                # crate new set in temporary list

                new_set = list(prime_set)
                new_set.append(prime)

                # check if it fullfils condition
                if len(new_set) >= SIZE_THRESHOLD:
#                    import ipdb
#                    ipdb.set_trace()
                    return new_set
                new_prime_sets.append(list(new_set))

        # append all new matching sets to list of sets
        for new_set in new_prime_sets:
            all_prime_sets.append(new_set)
        # add the prime itself
        all_prime_sets.append([prime])
    print("Not found.")
    return -1

t1 = datetime.datetime.now().replace(microsecond=0)
solution = compute_solution()
t2 = datetime.datetime.now().replace(microsecond=0)
print("The solution is : " + str(solution))
print("Finding solution took: " + str(t2 - t0))