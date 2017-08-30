
% q015
N = 20;

x = ones(N+1, N);

for j = 2:N,
    for i = 2:(N+1),
        x(i, j) = sum(x(i-1, 1:j));
    end;
end;

res = sum(x(:,20))

% alternative, using combinations
N = 20;
M = N;

res = prod((N+1):(N+M))/factorial(M)