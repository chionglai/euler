
% q002
N = 4e6;

x = [1, 2];
next = 3;
sum1 = 0;

while (next < N),
    x(1) = x(2);
    x(2) = next;
    
    next = sum(x);
    
    if (mod(next, 2) == 0),
        sum1 = sum1 + next;
    end;
    
end;

% Fibonacci sequence starts with 1. This is to compensate for 2
res = sum1 + 2
