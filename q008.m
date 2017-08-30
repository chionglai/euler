
% q008
nDigit = 13;

fn = 'q008_data.txt';
x = readChar(fn);

[yR, idxR] = largestAdjacentProd(x, nDigit);

res = yR