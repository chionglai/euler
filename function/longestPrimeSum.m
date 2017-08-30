
function [y, l] = longestPrimeSum(N)
% Note: the longest consecutive sum will be given by the smallest possible
% sum of primes. As such, 
% 1. Determine the longest consecutive sum of primes, starting from the
%    smallest prime that gives sum < desired limit.
% 2. Slowly reduce the list.
% 3. Shift the reduced list.
% 4. Find the sum and check if the sum is prime.

p = genPrime(N);

% using binary search to find the longest list
startIdx = 1;
endIdx = length(p);
while (startIdx < endIdx),
    midIdx = round((startIdx + endIdx)/2);
    total = sum(p(1:midIdx));
    if (total < N),
        startIdx = midIdx + 1;
    else
        endIdx = midIdx - 1;
    end;
end;

initLen = midIdx;

for i = initLen:-1:1,
    for j = 0:(initLen-i),
        idx = (1:i) + j;
        l = p(idx);
        y = sum(l);
        if (isprime(y)),
            return;
        end;
    end;
end;

end
