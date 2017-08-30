
function [idx, intStr] = getUniqueDigit(num)
% Function to eliminate from list num values with repeating digits.
% Inputs:
%   num: 1D array of int.
% Outputs:
%   idx: Array of indices such that num(idx) contains list of values with
%       unique digits only.
%   intStr: num(idx) in string.
%

nDigit = ceil(log10(max(num)));

intStr = cellstr(num2str(num, sprintf('%%0%dd', nDigit)));

% remove value with non-unique digits
for i = 1:size(intStr, 1),
    uni = unique(intStr{i});
    if (length(uni) ~= length(intStr{i})),
        intStr{i} = '';
    end;
end;
emptyIdx = cellfun(@isempty, intStr);
intStr = intStr(~emptyIdx);
idx = find(~emptyIdx);

end