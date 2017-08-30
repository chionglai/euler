
% q025

nDigit = 1000;

i = 2;
a = BigInt('1');
temp = [a; a];
while(1),
    i = i + 1;
    fibo = BigInt.sum(temp);
    temp(mod(i, 2) + 1) = fibo;
    
    if (length(fibo.Value) >= nDigit),
        break;
    end;
end;

res = i
