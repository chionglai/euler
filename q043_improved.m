
% q043 - improved: Using loop and modifying the result withon loop to avoid
% recursion.
% Algorithm:
% 1. Generate candidate of 3-digit multiple of 17 with unique digit first.
%    Call this list currList.
% 2. For each divisor (except for last one), do
%    a. Init newList to empty list. Increment shift.
%    b. For each value in currList, do
%       i. Get all digits 0-9 which are not in currVal.
%       ii. Append these availDigit to two most significant digit from
%           currVal to form list3d. 
%       iii. Retain only the entries in list3d that are divisible by
%           DIVISOR(i)
%       iv. Append remaining list3d to newList.
%    c. Assign newList to currList

UPPER = 1000;
DIVISOR = [1, 2, 3, 5, 7, 11, 13, 17].';
digit = '0123456789';

tic

% generate candidate of 3-digit multiple of 17 with unique digit first.
mul17  = DIVISOR(end);
mulList = (mul17:mul17:UPPER).';
[idx, ~] = getUniqueDigit(mulList);

currList = mulList(idx);
pow10 = 2;
shift = 0;
for i = (length(DIVISOR) - 1):-1:1,
    shift = shift + 1;
    
    newList = [];
    for j = 1:length(currList),
        % current value
        currVal = currList(j);
        
        % current value in str format
        currStr = num2str(currVal, sprintf('%%0%dd', shift + pow10));
        
        % Get available digit
        idxFlag = ismember(digit, currStr);
        availDigit = digit(~idxFlag);
        
        % Get new 3-digit, 1 digit from availDigit, 2-digits from currVal
        list3d = str2num(availDigit.') * 10^(pow10) + floor(currVal / 10^ shift);
        list3d = list3d(mod(list3d, DIVISOR(i)) == 0);
        
        newList = [newList; list3d * 10^shift + mod(currVal, 10^shift)];
    end;
    
    currList = newList;
end;
pandList = uint32(currList);

res = uint32(sum(pandList))

toc


