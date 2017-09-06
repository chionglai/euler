
% function: largestDiagonalProd(x, N)
% purpose: Calculate the diagonal product for a given matrix x.
% input: 
%   x: 2D matrix with number of columns >= N.
%   N: Number of diagonal product to calculate.
% output: 
%   y: The maximum N diagonal product in matrix x.
%   idx: The [row, col] index in matrix x that produces maximum N diagonal
%       product y.
function [y, idx] = largestDiagonalProd(x, N)

[row, col] = size(x);

startI = -row + N;
endI = col - N;

maxD = zeros(endI - startI + 1, 1);
idx2 = zeros(endI - startI + 1, 2);

for i = 1:length(maxD),
    xD = diag(x, i-1+startI);
    
    [maxD(i), idx2(i, :)] = largestAdjacentProd(xD(:).', N);
end;

[y, ci] = max(maxD);
idx = [ci, idx2(ci, 1)];
