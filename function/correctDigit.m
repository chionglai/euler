function [ y ] = correctDigit( x )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

carry = 0;
for i = length(x):-1:1,
    carry = floor(carry/10) + x(i);
    x(i) = mod(carry, 10);
end;

if (carry > 0),
    y = [int2dig(carry), x];
else
    y = x;
end;

end

