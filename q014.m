
% q014

N = 1000000;

% for other numbers
[y, L] = getCollatzLen(N, 'function/collatz.mat');

[C, idx] = max(L);
res = idx
