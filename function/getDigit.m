
% function: getDigit(x, n)
% purpose: Get the n^th digit of a given integer x.
% input:
%   x = An integer
%   n = The index of the digit in x to be obtained, starting from least
%       significant as index 1.
% output:
%   y = The n^th digit of integer x.
function [ y ] = getDigit( x, n )

upper = floor(log10(abs(x))) + 1;

assert(n > 0, 'getDigit', 'Negative index not implemented yet.');
assert(n <= upper, 'getDigit', 'Index exceeds length.');

y = mod(floor(x/10^(n-1)), 10);

end

