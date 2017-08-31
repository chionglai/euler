
% q067

% 3x3 Sudoku
N = 9;

% read from file
fn = 'q096_data.txt';

fid = fopen(fn, 'r');

line = fgetl(fid);
s = 0;
v = [100; 10; 1];
while (line ~= -1),
    prob = zeros(N, N);
    
    % read from file and form into sudoku problem
    for i = 1:N,
        line = fgetl(fid);
        for j = 1:N,
            prob(i, j) = str2double(line(j));
        end;
    end;
    % ignore "Grid XX"
    line = fgetl(fid);
    
    sol = solveSudoku(prob);
    
    leftCorner = sol(1, 1:3);
    s = s + leftCorner * v;
end;

res = s