
% function: fibonacci.m
% purpose: Get the n^th Fibanacci number.
% inputs: 
%   n = Index of the Fibanacci number to obtain.
%   mode = (optional) 'single' to return only the n^th Fibanacci number.
%       Otherwise, return a vector of Nx1 of 1st till n^th Fibonacci
%       number.
% outputs: 
%   y = Fibonacci number.
function [ y ] = fibonacci( n, varargin )

% default optional arguments
defArg = {'sequence'};

nVarargin = length(varargin);
maxOpt = 1;
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
[mode] = optArg{:};

y = ones(n, 1);

for i = 3:n,
    y(i) = y(i-1) + y(i-2);
end;

if(strncmpi(mode, 'single', 2)),
    y = y(n);
end;

end

