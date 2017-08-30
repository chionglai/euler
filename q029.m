
% q029

lim = [2, 100];

len = diff(lim) + 1;
term = zeros(len, len);

nn = lim(1):lim(2);

for i = 1:length(nn),
    term(i, :) = nn(i).^nn;
end;

uTerm = unique(term(:));
res = length(uTerm)
