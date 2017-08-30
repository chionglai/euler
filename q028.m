
% q028

N = 1001;

% Diagonal     start  step
%  1               1     0  (trivial case)
%  3  5  7  9      3     2
% 13 17 21 25     13     4
% 31 37 43 49     31     6
% 57 65 73 81     57     8


nDiagTerm = 2*N - 1;

diagTerm = zeros(nDiagTerm, 1);

% initialise sequence
diagTerm(1) = 1;    % for trivial case 1x1 matrix
count = 0;
step = 2;
for i = 2:nDiagTerm,
    count = count + 1;
    diagTerm(i) = diagTerm(i-1) + step;
    
    if (mod(count, 4) == 0),
        % on every fourth entry (the last diagonal term for each circle)
        step = step + 2;
        count = 0;
    end;
end;

res = sum(diagTerm)
