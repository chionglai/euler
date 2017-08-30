
% q020

N = 100;

a = BigInt('1');

for i = 2:N,
    a = a * BigInt(num2str(i));
end;

res = sum(a.Value - '1' + 1)