
% q047

% number of prime factors
N = 4;

% number of consecutive numbers
len = 4;

% the number exist between this range
startIdx = 99997;
endIdx = 1e6;

cFac = zeros(len, 1);

j = 0;
for i = startIdx:endIdx,
    if (~isprime(i)),
        fac = factor(i);
        fac = unique(fac);
    else
        fac = i;
    end;
        
    j = j + 1;
    cFac(j) = length(fac);
    j = mod(j, len);
        
    if (sum(cFac == N) == len),
        break;
    end;
end;

res = i - len + 1