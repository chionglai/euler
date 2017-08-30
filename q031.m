
% q031

% Note:
% 1. For each value, need to store the number of coin combination from a
%    subset of 1 up to K. e.g. For 15, 
%                idx [1, 2, 3,  4,  5,  6,   7,   8]
%    Largest coin, K [1, 2, 5, 10, 20, 50, 100, 200]
%        num{i = 15} [1, 7, 10, 4,  0,  0,   0,   0]
%                     ^  ^   ^  ^   ^
%                     a  b   c  d   e
%    a. Number of coin combination using just coin 1 to build up value 15
%    b. Number of coin combination using coin 1 and 2 (must have at least 
%       one) to build up value 15
%    c. Using [1, 2, 5 (must have at least one)]
%    d. Using [1, 2, 5, 10 (must have at least one)]
%    e. Using [1, 2, 5, 10, 20 (must have at least one)]
% 2. When doing by hand, there is a pattern and hence the above storage
%    requirements.
%
% Algorithm:
% 1. Case $1 is trivial.
% 2. For i = $2 to UPPER, 
%    a. if value of i match one of the coin, +1. 
%    b. find all the coins such that 2 <= coins < i. coin = 1 is trivial
%       and not included. Call this set subCoin.
%    c. For each subCoin,
%       i. find val = i - subCoin(j)
%       ii. find all the coin combinations for val using coins only the 
%           coins [1, ..., subCoin(j)]
%       ii. This combinations will form the combinations for value = i
%           using coins [1, ..., subCoin(j)]
% 3. Solution will be the sum of num{i = 200}.

UPPER = 200;

set = [1, 2, 5, 10, 20, 50, 100, 200];

num = cell(UPPER, 1);

initLen = zeros(size(set)).';
initLen(1) = 1;
num{1} = initLen; % trivial case
for i = 2:UPPER,
    len = initLen;
    idx = find(set <= i, 1, 'last');
    
    if (ismember(i, set)),
        len(idx) = 1;
        idx = idx - 1;
    end;
    
    for j = 2:idx,
        val = i - set(j);
        len(j) = sum(num{val}(1:j));
    end;
    num{i} = len;
end;

res = sum(num{200})


