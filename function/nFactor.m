
% function: nFactor.m
% purpose: to calculate the number of all factors of an integer, including
%   1 and itself. Any integer N can be expressed as
%           N = p_1^(a_1) * p_2^(a_2) * p_3^(a_3) * ...
%   where p_n is a prime factor, and a_n is the exponent. The number of
%   divisors,
%           D(N) = (a_1 + 1) * (a_2 + 1) * (a_3 + 1) * ...
% input:
%   x = an integer
% output:
%   y = number of factors
function y = nFactor(x)

fac = factor(x);
C = unique(fac);

y = 1;
for i = 1:length(C),
    y = y * (sum(fac == C(i)) + 1);
end;
