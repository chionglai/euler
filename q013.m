
% q013
N = 100;
nDigit = 50;
fn = 'q013_data.txt';

fid = fopen(fn, 'r');

x = cell(N, 1);
i = 1;
tline = fgetl(fid);
while(i < N && ischar(tline)),
    x{i} = tline;
    tline = fgetl(fid);
    i = i + 1;
end;
fclose(fid);

if (i ~= N),
    error('Number of lines read is not as expected!');
else
    x{i} = tline;
end;

% x = {'123', '-405', '678'};

y = largeSum(x);

res = y


