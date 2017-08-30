
% q010
N = 2e6;
x = ones(N, 1, 'uint8');

for i = 2:N,
    x((2*i):i:N) = 0;
end;

% 1 is not a prime number
x(1) = 0;

res = sum(find(x))