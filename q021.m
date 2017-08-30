
% q021

N = 10000;

total = 0;
flag = ones(N, 1);

for i = 2:N,
    if (flag(i)),
        fac = factor1(i);
        x = sum(fac(1:(end-1)));
        flag(i) = 0;
    end;
    
    if (x <= N && flag(x)),
        fac = factor1(x);
        y = sum(fac(1:(end-1)));
        flag(x) = 0;
        
        if (y ~= x && y == i),
            total = total + i + x;
        end;
    end;
end;

res = total