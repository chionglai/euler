
% q048

N = 1000;
nLastDigit = 10;

total = BigInt('0');
for i = 1:N,
    total = total + BigInt(num2str(i))^i;
end;

res = total.Value((end-nLastDigit+1):end)