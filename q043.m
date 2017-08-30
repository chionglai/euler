
% q043

% Algorithm:
% A. Generating list
% 1. Start with divisible of 17, get all 3 digit multiple of 17.
% 2. Trim the list by removing values with non-unique digits.
% 3. Repeats for other multiples till 1.***
%
% B. Finding list
% 1. Start from list{n=end}.
% 2. For each value in list{n},
%    a. Find values in list{n-1} that match 0xx - xx0 of current value.
%    b. Further trim the list to exclude values containing the digits
%       already considered.
%    c. Recursion. For each values in list{n - 1},
%       i. ...
%    d. Recursion terminating condition: n == 1
%       i. Find matching 0xx - xx0 values in list{1}.
%       ii. Remove values containing digits already considered.
%       iii. Append remaining list with excDigit, and return.
% 3. Result = sum(pandigital list).
%
% Note:
% ***For multiple of 1, there is no need to generate the list, since it is
% the last, and we can look at the generated list to find the mising digit.

function res = q043()
UPPER = 1000;
DIVISOR = [1, 2, 3, 5, 7, 11, 13, 17].';

tic

threeDigitList = cell(length(DIVISOR), 1);

% generate candidate of 3-digit multiple of 17 with unique digit first.
mul = DIVISOR(end);
mulList = (mul:mul:UPPER).';
[idx, ~] = getUniqueDigit(mulList);
threeDigitList{end} = mulList(idx);
for i = (length(DIVISOR)-1):-1:1,
    mul = DIVISOR(i);
    mulList = (mul:mul:UPPER).';
    
    % trim to only have 3 unique digits
    [idx, ~] = getUniqueDigit(mulList);
    mulList = mulList(idx);
    
    % further trim the unique 3-digit with previous 3-digit, such that 0xx
    % of current list must match xx0 of previous list, where xx are the
    % unique digits that match
    prevList = threeDigitList{i + 1};
    prevList2d = floor(prevList / 10);
    
    currList2d = mod(mulList, 100);
    threeDigitList{i} = mulList(ismember(currList2d, prevList2d));
end;

% construct the list from the trimmed list
n = length(DIVISOR);
list = threeDigitList{n};
pandList = [];
for i = 1:length(list),
    seed = list(i);
    excDigit = num2str(mod(seed, 10), '%01d');
    pandList = [pandList; catNum(threeDigitList, n - 1, seed, excDigit)];
end;

res = uint64(sum(pandList));
toc
end


function value = catNum(list, n, seed, excDigit)
%
% list - Contains the whole list, i.e. threeDigitList
% n    - Current iteration/index of list
% seed - Current 3-digit seed. list{n} must have 0xx values that match this
%        seed's xx0 digits.
% excDigit - Digits (in order) that have previously occured and need to be 
%        excluded in current list{n}

if (n == 1), 
    % trim - matching 0xx from list{n} to xx0 of seed
    seed2d = floor(seed / 10);
    list2d = mod(list{n}, 100);
    idx = find(ismember(list2d, seed2d));
    
    value = [];
    for i = idx(:).',
        num = list{n}(i);
        
        % further trim to exclude digit already in previous seed
        intStr = num2str(num, '%03d');
        if (~any(ismember(intStr, excDigit))),
            % append all digit found, and cast to uint64
            value = [value; str2num(sprintf('uint64(%s)', [intStr, excDigit]))];
        end;
    end;
else
    value = [];
    % trim - matching 0xx from list{n} to xx0 of seed
    seed2d = floor(seed / 10);
    currList = list{n};
    currList2d = mod(currList, 100);
    idx = find(ismember(currList2d, seed2d));
    
    % attach new digit
    for i = (idx(:)).',
        % current excDigit
        currExcDigit = excDigit;
        
        % new seed
        currSeed = currList(i);
        
        % further trim to exclude digit already in previous seed
        if (any(ismember(num2str(currSeed, '%03d'), currExcDigit))),
            continue;
        end;

        currExcDigit = [num2str(mod(currSeed, 10), '%01d'), currExcDigit];
        
        % recursively get next list and append
        digitList = catNum(list, n - 1, currSeed, currExcDigit);
        value = [value; digitList];
    end;
end;

end
