function [ y ] = correctDigit( x, base )
% function: correctDigit(x, base)
% purpose: Each element in array x is considered to be a single digit for 
%   a given base. This function is to perform the carry operation for each
%   element in array x in case they do not fall between [0, base).
% input:
%   x: Array of positive integer where each element represent a single
%       digit for a given base.
%   base: The base for the value in x.
% output:
%   y: Corrected array of x.

if (~exist('base', 'var')),
    base = 10;
end;

carry = 0;
for i = length(x):-1:1,
    carry = floor(carry/base) + x(i);
    x(i) = mod(carry, base);
end;

carry = floor(carry/base);
if (carry > 0),
    y = [int2dig(carry, base), x];
else
    y = x;
end;

end

