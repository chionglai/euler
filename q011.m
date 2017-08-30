
% q011
N = 4;

fn = 'q011_data.txt';
row = 20;
col = 20;
x = readArray(fn, ' ', row, col);

% horizontal: left-right
[yH, idxH] = largestAdjacentProd(x, N);

% vertical: up-down
[yV, idxV] = largestAdjacentProd(x.', N);

% diagonal
[yD, idxD] = largestDiagonalProd(x, N);

% anti-diagonal
[yAD, idxAD] = largestDiagonalProd(fliplr(x), N);

res = max([yH, yV, yD, yAD])