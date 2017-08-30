
% function: largeSum.m
% purpose: to calculate sum of very large integer values. All values are
%   represented in string. The idea is to add a block (i.e. part of the
%   large integer) at a time and add the carry to the next significant
%   block.
% input:
%   x = Cell containing large integers represented in string. The 
%       string/integer in each cell entry can have different length. The
%       numbers can be negative.
%   maxDigit = (Optional) Maximum digit for each entry in cell x. If not
%       specified, will automatically calculate the maximum digit required.
%   nDigitPerBlock = (Optional) Number of decimal digit to be processed per 
%       block. The larger it is, the faster the calculation. Default to
%       log10(intmax('int32')).
% output:
%   y = The sum of all large number in x, with leading (unsignificant
%       zeros) removed.
function y = largeSum(x, varargin)

x = x(:);
N = length(x);
ll = cellfun('length', x);

% default optional arguments
defArg = {max(ll), floor(log10(double(intmax('int32'))))};

nVarargin = length(varargin);
maxOpt = 2;
if (nVarargin > maxOpt),
    error('uniques2:TooManyInputs', ...
        'At most %d optional inputs', maxOpt);
end;

% Select between default or specified optional args
optArg = defArg;
optArg(1:nVarargin) = varargin;

% find indices to empty optional args
empIdx = cellfun('isempty', optArg);

% replace empty args with default optional args
optArg(empIdx) = defArg(empIdx);

% Place optional args in memorable names
[maxDigit, nDigitPerBlock] = optArg{:};


nBlock = ceil(maxDigit/nDigitPerBlock);
nDigit = nBlock*nDigitPerBlock;
fac = 10^nDigitPerBlock;

xArr = zeros(N, nBlock);

% formatting string representation into blocks of integer
for i = 1:N,
    nPad = nDigit - length(x{i});
    str = x{i};
    if (str(1) == '-'),
        sign = -1;   % it is a negative number.
        str(1) = '0';   % remove '-' sign.
    else
        sign = 1;
    end;
    
    if (nPad > 0),
        % pad leading insignificant zeros
        strFmt = ['%0', num2str(nPad), 'd%s'];
        str = sprintf(strFmt, 0, str);
    end;
    xMat = vec2mat(str, nDigitPerBlock);
    
    xTemp = str2num(xMat);
    
    xArr(i, :) = sign*xTemp;
end;

% sum each block
sumArr = sum(xArr, 1);

% apply carry to the next significant block
carry = 0;
for i = nBlock:-1:1,
    carry = floor(carry/fac) + sumArr(i);
    sumArr(i) = mod(carry, fac);
end;
carry = floor(carry/fac);

% if negative, apply 10's complement
if (carry == -1),
    % find the last non-zero digit just before the trailing zeros
    idx = find(sumArr, 1, 'last');
    
    % apply 10's complement
    sumArr(1:(idx-1)) = (fac - 1) - sumArr(1:(idx-1));
    sumArr(idx) = fac - sumArr(idx);

    % combine all blocks. Carry is NOT included.
    strFmt = ['%0', num2str(nDigitPerBlock), 'd'];
    yStr = sprintf(strFmt, sumArr);

    % remove any leading/insignificant zeros
    y = regexprep(yStr, '^0*', '');
    
    y = ['-', y];
else
    % combine carry and all blocks.
    strFmt = ['%0', num2str(nDigitPerBlock), 'd'];
    yStr = sprintf(strFmt, carry, sumArr);

    % remove any leading/insignificant zeros
    y = regexprep(yStr, '^0*', '');
end;
