
% q042

% tolerance for double comparison
tol = 100*eps;

% read from file
fn = 'q042_data.txt';

fid = fopen(fn, 'r');
str = fscanf(fid, '%s');
fclose(fid);

% remove delimiters and only gets the names
pat = '\w+';
names = regexp(str, pat, 'match');

% as pre-caution
names = upper(names(:));

offset = 'A' - 1;

% Using loop
triCount = 0;
coef = [1, 1, 0];
for i = 1:length(names),
    val = sum(names{i} - offset);
    coef(3) = -2*val;
    
    p = roots(coef);
    idx = find(abs(imag(p) <= tol) & (p > 0) & (abs(p - round(p)) <= tol));
    if (~isempty(idx)),
        triCount = triCount + 1;
    end;
end;

res = triCount
