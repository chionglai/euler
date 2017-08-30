
% q046

% Algorithm:
% 1. Given, oc = p + 2 * i ^ 2,
%    where, oc = odd composite. An odd composite number is a odd, non-prime
%           number.
%           p = any prime
%           i = any positive integer
% 2. Rearrange to get, i = sqrt( (oc - p) / 2 ).  --(1)
%    a. (oc - p) must be positive
%    b. i must be an integer
% 3. Brute force to search for the first oc that does not have an 
%    integer i.
%    a. For a given oc, let p = primes < oc
%    b. If there does NOT exist i in positive int such that (1) is true for
%       all p, then result = oc.

LOWER = 1000;
UPPER = 10000;

tic

% prime must not be filtered by LOWER.
prime = genPrime(UPPER);
oddAll = (5:2:UPPER);
oddAll = oddAll(oddAll > LOWER);

% remove prime odds from oddAll. Composite odd number must not contains
% prime numbers
idx = ismember(oddAll, prime);
odd = oddAll(~idx);

i2 = bsxfun(@minus, odd, prime) / 2;

nOdd = length(odd);
for idx = 1:nOdd,
    i2Val = i2(:, idx);
    
    % must be positive
    i2Val = i2Val(i2Val > 0);

    iVal = sqrt(i2Val);
    
    if (all(mod(iVal, 1) > 0)),
        fprintf('Result found. Result = %d\n', odd(idx));
        break;
    end;
end;

toc

res = odd(idx)



