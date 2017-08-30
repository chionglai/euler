
% q053
% Note: For this problem, the actual value is not important. We only need
% to check if it exceed upper or not.

N = 100;
upper = 1e6;

count = 0;
% case i = 1 and 2 are trivial and not included.
for i = 3:N,
    kN = ceil(i/2);
    
    % loop for k = 1 to (ceil(n/2) - 1)
    for k = 1:(kN-1),
        nCr = nchoosek(i, k);
    
        if (nCr >= upper),
            % +2 due to symmetry, i.e. nchoosek(n, k) == nchoosek(n, n-k)
            count = count + 2;
        end;
    end;
    
    % for i == even, exact mid point of k = i/2
    if (mod(i, 2) == 0),
        nCr = nchoosek(i, i/2);
    
        if (nCr >= upper),
            count = count + 1;
        end;
    end;
end;

res = count