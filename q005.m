
% q005
% get prime number between 2 and 20
prime = [2, 3, 5, 7, 11, 13, 17, 19];

exp = floor(log2(20)./log2(prime));

res = prod(prime.^exp)