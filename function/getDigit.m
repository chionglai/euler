function [ y ] = getDigit( x, n )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

upper = floor(log10(abs(x))) + 1;

assert(n > 0, 'getDigit', 'Negative index not implemented yet.');
assert(n <= upper, 'getDigit', 'Index exceeds length.');

y = mod(floor(x/10^(n-1)), 10);

end

