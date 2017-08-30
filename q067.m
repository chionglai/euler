
% q067

% read from file
fn = 'q067_data.txt';

fid = fopen(fn, 'r');
[y, c] = fscanf(fid, '%d');
fclose(fid);

rr = roots([1, 1, -2*c]);
r = rr(rr > 0);
r = round(r);

X = spalloc(r, r, c);

next = 0;
for i = 1:r,
    X(i, 1:i) = y((1:i) + next);
    next = next + i;
end;

[m, i, v] = maxTri(X);

res = m