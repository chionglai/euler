

% function: largestAdjacentProd(x, N)
% purpose: Calculate the adjacent product for a given matrix x.
% input: 
%   x: 2D matrix with number of columns >= N.
%   N: Number of adjacent product to calculate.
% output: 
%   y: The maximum N adjacent product in matrix x.
%   idx: The [row, col] index in matrix x that produces maximum N adjacent
%       product y.
function [y, idx] = largestAdjacentProd(x, N)

[r, c] = size(x);

prodTable = zeros(r, c-N+1);

for i = 1:r,
    for j = 1:c-N+1,
        prodTable(i, j) = prod(x(i, (1:N)+j-1));
    end;
end;

[c1, i1] = max(prodTable);
[c2, i2] = max(c1);

y = c2;
idx = [i1(i2), i2];     % [rowIdx, colIdx]
