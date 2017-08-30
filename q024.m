
% q024

dig = '0123456789';
ith = 1e6;


p = perms(dig);
[pSorted, idx] = sortrows(p);

res = p(idx(ith), :)