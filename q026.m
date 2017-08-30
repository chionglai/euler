
% q026

% Note: 
% 1. Longest recurring cycle is given by prime denominator.
% 2. Recurring cycle repeats itself every time when remainder of 
%    mod(10*previousRemainder, n) is 1. Exception is for single digit recurring
%    cycle, e.g. 1/3 or 1/6, where the loop termination condition is when
%    currentRemainder == previousRemainder
%
% Algorithm:
% 1. Get all prime numbers from 2 to UPPER
% 2. For each number/candidate, 
%       loop till currRem == 1 OR currRem == prevRem
% 3. The number of loop iteration gives the length of recurring cycle.

UPPER = 1000;

d = genPrime(UPPER);

len = zeros(size(d));

for i = 1:length(d),
    prevRem = 0;
    currRem = 10;
    while (currRem ~= 1 && currRem ~= prevRem),
        prevRem = currRem;
        len(i) = len(i) + 1;
        currRem = mod(10*prevRem, d(i));
    end;
    
    % special cases
    if (currRem == prevRem),
        if (currRem == 0),
            % non-recurring cycle
            len(i) = 0;
        else
            % e.g. 0.1(6) or 0.(3)
            len(i) = 1;
        end;
    end;
end;

[maxLen, idx] = max(len);
res = d(idx)