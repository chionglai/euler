

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
