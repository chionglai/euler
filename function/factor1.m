
% function: factor1.m
% purpose: to get all the factors (including non-prime factors, 1 and the
%   number itself) of a natural number.
% input:
%   x = A natural number.
% output:
%   y = An array containing all factors for x.
function y = factor1(x)

% candidate factor. The indices give the factor, the entry (0 or 1) flag if
% the index is a factor or not
cFac = sparse(x, 1);

% get prime factors. The factors may repeat.
primeFac = factor(x);

% get unique prime factors
[uPrimeFac, uIdx, ~] = unique(primeFac);

% get index of non-unique prime factos
nuIdx = setdiff((1:length(primeFac)).', uIdx(:));
nuPrimeFac = primeFac(nuIdx);

% length of unique prime factor
nC = length(uPrimeFac);

% length of non-unique prime factor
nuC = length(nuPrimeFac);

% build a list of factors from unique prime factors. The resulted factors
% may not be unique
fac = uPrimeFac(:);
for i = 2:nC,
    combi = nchoosek(uPrimeFac, i);
    
    for j = 1:size(combi, 1),
        fac = [fac; prod(combi(j, :))];
    end;
end;

% factors built from unique prime factors
cFac(fac) = 1;

% build factors from list from unique prime factor and non-unique prime
% factors.
for i = 1:nuC,
    combi = nchoosek(nuPrimeFac, i);
    
    for j = 1:size(combi, 1),
        newFac = fac*prod(combi(j, :));
        
        cFac(newFac) = 1;
    end;
end;

% 1 is always a factor
cFac(1) = 1;

% indices with entry == 1 are the factors.
y = find(cFac);