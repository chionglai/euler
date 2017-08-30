

% Given two equations
%   a^2 + b^2 = c^2     -- 1
%   a + b + c = 1000    -- 2
% 
% substitute (2) into (1) and solve for b results in
%   b = 1000*(500-a)/(1000-a)
% Now, only need to find 1 <= a <= 499 where b will be a positive integer

for a = 1:499,
    b = 1000*(500 - a)/(1000 - a);
    
    if (mod(b,1) == 0),
        break;
    end;
end;

c = 1000 - a - b;

res = a*b*c