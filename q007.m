
% q007

N = 10001;

scale = 100;
next = scale*N;

y = 0;
while length(y) < N,
    y = genPrime(next);
    next = scale*next;
end;

res = y(N)