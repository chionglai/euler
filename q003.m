
% q003
N = 600851475143;
k = floor(sqrt(N));
p = genPrime(k);

for i = length(p):-1:1,
    if(mod(N/p(i), 1) == 0),
        break;
    end;
end;

res = p(i)