function [ y ] = int2dig( x, base )
% function: int2dig(x, base)
% purpose: Split a positive integer into and array of integer with a
%   given base, where each array element represent the i^th digit of the
%   number in the given base. E.g. int2dig(123, 10) will result in 
%   [1, 2, 3].
% input:
%   x: A positive integer
%   base: Base for the split. If not supplied, will default to 10.
% output:
%   y: An array of digit for the given base for the integer x.

if (~exist('base', 'var')),
    base = 10;
end;

if (x < 0),
    error('Error: x must be positive.');
elseif (x < 2),
    y = x;
else
    N = ceil(log10(x) / log10(base));

    y = zeros(1, N);
    temp = x;
    for i = 1:N,
        y(end-i+1) = mod(temp, base);

        temp = floor(temp/base);
    end;
end;

end

