
% q037

UPPER = 11;

prime = genPrime(1000000);   % arbitrarily chosen upper limit for primes

truncPrime = zeros(UPPER, 1);
i = 0;
idx = find(prime > 10, 1, 'first');     % at least two digits
while (i < UPPER),
    factor = 10;
    
    testPrime = prime(idx);
    while (factor < testPrime),
        left = floor(testPrime / factor);
        if (~ismember(left, prime)),
            break;
        end;
        
        right = mod(testPrime, factor);
        if (~ismember(right, prime)),
            break;
        end;
        
        factor = factor * 10;
    end;
    
    if (factor > testPrime),
        i = i + 1;
        truncPrime = testPrime;
    end;
    idx = idx + 1;
end;

res = sum(truncPrime)