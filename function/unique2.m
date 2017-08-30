
% function: unique2.m
% purpose: to extend Matlab unique.m functions to be able to specify any
%   number of occurrence as unique. For example, N = 2 means any numbers
%   occurring less than or equals to 2 times will be a unique number.
% input:
%   x = An array of integers.
%   N = Number of occurrence.
%   order = Either 'stable' or 'sorted' as Matlab unique.m
% output:
%   C = List of unique numbers.
%   ia = Indices such that x(ia) == C
%   ic = Indices such that C(ic) == x
function [C, ia, ic] = unique2(x, varargin)

% default optional arguments
defArg = {1, 'sorted'};

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
[N, order] = optArg{:};


[C1, ia1] = unique_int(x, N);

if (strncmpi(order, 'stable', 2)),
    [~, i] = sort(ia1);
else
    [~, i] = sort(C1);
end;

C = C1(i);
ia = ia1(i);

% there is a relationship between ia and ic. I am using this relationship
% to calculate ic from ia
ic = ones(length(x), 1);
icInd = (1:length(x)).';
for i = 2:length(ia),
    ic = ic + 1.*(icInd >= ia(i));
end;



function [C0, ia0] = unique_int(x, N)

if (N > 0),
    [C0, ia0, ~] = unique(x);
    
    idx = setdiff((1:length(x)).', ia0);
    
    [C1, ia1] = unique_int(x(idx), N-1);
    C0  = [C0(:); C1];
    ia0 = [ia0(:); idx(ia1)];
else
    C0 = [];
    ia0 = [];
    return;
end;