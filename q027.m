
% q027

% Note:
% 1. b must be positive and a prime, since n = 0 needs to produce a prime.
% 2. a does not need to be prime, and starts from 1
%
% Algorithm:
% 1. We have pAll = n^2 + an + b, where pAll is prime numbers and n = 0:longest. 
% 2. Rewrite such that (pAll - b) = n^2 + an. 
% 3. For positive a, 
%    a. for a given b, reduce list pAll to p such that p > b
%    b. set n = 1, hence a = p - b - 1 is the candidate for a. At this
%       point, list of candidate a can be trimmed to abs(a) < UPPER.
%    c. use this candidate a (with its corresponding b) to generate a list
%       (call it testList) of primes using the generating function.
%    d. flag all the entries in testLib that are in p
%    e. find the length of consecutive set flag starting from index 1. This
%       (length + 1) gives the length of the longest n. +1 is for n=0.
% 4. For negative a,
%    a. for a given b, reduce list pAll to p such that p < b.
%    b. Do step 3.b to 3.e

UPPER = 1000;
N_PRIME = 10e6;     % Upper limit for primes
N_UPPER = 100;      % Upper limit for n

allPrime = genPrime(N_PRIME);

idx = find(allPrime < UPPER, 1, 'last');

% list of candidates for b
bList = allPrime(1:idx);

bLen = length(bList);
lenPos = cell(bLen, 1);    % length of consecutive n for a given aList(i) and bList(i)
lenNeg = cell(bLen, 1);

n = (1:N_UPPER).';

maxLen = 0;
maxA = 0;
maxB = 0;

% start with b
for i = bLen:-1:1,
    b = bList(i);
    
    %% For Positive a
    % list of primes greater than candidate b. This is for
    % positive a
    p = allPrime(allPrime > b);
    
    % (p - b) = n^2 + a*n
    pMb = p - b;
    aCandList = pMb - 1;
    
    aCandList = aCandList(aCandList < UPPER);
    aLen = length(aCandList);
    
    aList = zeros(aLen, 1);     % list of candidate a for each b
    lenList = zeros(aLen, 1);   % list of consecutive primes length for a given a and b
    for j = 1:aLen,
        a = aCandList(j);
        aList(j) = a;
        
        % list of primes generated using the a and b candidate
        testList = n.^2 + a*n + b;

        % get all members of testList that are in p
        isMem = ismember(testList, p);

        % get the length of the consecutive primes
        lenCon = find(diff(isMem) ~= 0, 1, 'first');

        % +1 is because n=0 is not included in the calculation, but is actually
        % needed.
        lenList(j) = lenCon + 1;
    end;
    
    [m, idx] = max(lenList);
    if (m > maxLen),
        maxLen = m;
        maxA = aList(idx);
        maxB = b;
    end;
    
    data.b = b;
    data.aList = aList;
    data.lenList = lenList;
    lenPos{i} = data;
    
    %% For negative a
    % list of primes greater than candidate b. This is for
    % positive a
    p = allPrime(allPrime < b);
    
    % (p - b) = n^2 + a*n
    pMb = p - b;  
    aCandList = pMb - 1;
    
    aCandList = aCandList(abs(aCandList) < UPPER);
    aLen = length(aCandList);
    
    aList = zeros(aLen, 1);     % list of candidate a for each b
    lenList = zeros(aLen, 1);   % list of consecutive primes length for a given a and b
    for j = 1:aLen,
        a = aCandList(j);
        aList(j) = a;
        
        % list of primes generated using the a and b candidate
        testList = n.^2 + a*n + b;

        % get all members of testList that are in p
        isMem = ismember(testList, p);

        % get the length of the consecutive primes. For negatve a, the
        % direction of increasing n results in primes in opposite/reversed
        % direction
        lenCon = find(diff(isMem) ~= 0, 1, 'first');

        % +1 is because n=0 is not included in the calculation, but is actually
        % needed.
        lenList(j) = lenCon + 1;
    end;
    
    [m, idx] = max(lenList);
    if (m > maxLen),
        maxLen = m;
        maxA = aList(idx);
        maxB = b;
    end;
    
    data.aList = aList;
    data.lenList = lenList;
    lenNeg{i} = data;
end;

res = maxA * maxB