
% q040

% Note:
% 1. The group length Ln for n-digit values are given by
%       Ln = 9 * nDigit * 10 ^ (nDigit - 1)
%    E.g. group of 1-digit (i.e. [1, 9] is given by L1 = 9, group of
%    4-digit (i.e. [1000, 9999]) is given by L4 = 9 * 4 * 10 ^ (4 - 1) =
%    36000
% 2. Start index SN for the n-digit group is given by
%       SN = 1 + \sum_{n = 1}^{N-1} Ln
%
% Algorithm:
% 1. (Optional) Create an array of Ln, where its indices represent n.
% 2. Create an array of SN, where its indices represent N. Given this array
%    of SN, Ln array can be found for (N-1) using diff().
% 3. Given a digit location x (in the problem it is called n), we can use
%    the following steps to find the digit value.
%    a. Find which n-digit group, n does x belong to using SN array.
%    b. Find which digit (ones, tens, hundreds, etc) that x belongs to
%       using
%           pos = (x - SN(n)) % n,
%       where pos == 0 for MSB, p == (n - 1) for LSB.
%    c. Based on pos, the following three equations can be used to find the
%       value for different pos, must be in this order for the if-else
%       i. For pos == 0 (MSB),
%               val = 1 + floor( (x - SN(n)) / (n * 10 ^ (n - 1)) )
%       ii. For pos == n - 1 (LSB), 
%               val = floor( mod( (x - SN(n)), n * 10 ^ (n - 2) ) / n )
%       iii. For any other pos,
%               val = floor( mod( (x - SN(n)), n * 10 ^ (n - 1)) / (n * 10 ^ (n - 2)) )

POSITION = 10 .^ (0:6);
MAX_DIGIT = 6;

tic;

maxVal = POSITION(end);
nDigit = (1:MAX_DIGIT).';

% Generate Ln
Ln = 9 .* nDigit .* 10 .^ (nDigit - 1);

% Generate SN
SN = cumsum([1; Ln]);
assert(maxVal < SN(end), 'Last entry of SN must be greater. Increase MAX_DIGIT.')

% 3.a. logMat is a (MAX_DIGIT + 1) x POSITION matrix, where each column
% vector logMat(:, i) gives the group n where x belongs
logMat = bsxfun(@ge, POSITION, SN);

Npos = length(POSITION);
nList = zeros(Npos, 1);
posList = zeros(Npos, 1);
valList = zeros(Npos, 1);
for i = 1:Npos,
    x = POSITION(i);
    
    n = find(logMat(:, i), 1, 'last');
    
    pos = mod((x - SN(n)), n);
    
    if (pos == 0),
        val = 1 + floor( (x - SN(n)) / (n * 10 ^ (n - 1)) );
    elseif (pos == (n - 1)),
        val = floor( mod( (x - SN(n)), n * 10 ^ (n - 2) ) / n );
    else
        val = floor( mod( (x - SN(n)), n * 10 ^ (n - 1) ) / (n * 10 ^ (n - 2)) );
    end;
    
    nList(i) = n;
    posList(i) = pos;
    valList(i) = val;
end;

toc

res = prod(valList)

