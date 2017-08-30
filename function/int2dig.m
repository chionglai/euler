function [ y ] = int2dig( x )

% add base
% add checking, x positive

%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

if (x < 0),
    error('Error: x must be positive.');
elseif (x < 2),
    y = x;
else
    N = ceil(log10(x));

    y = zeros(1, N);
    temp = x;
    for i = 1:N,
        y(end-i+1) = mod(temp, 10);

        temp = floor(temp/10);
    end;
end;

end

