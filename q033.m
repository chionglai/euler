
% q033

% Note:
% 1. num/den value is less than 1
% 2. Both num and den have two digits
% 3. Using these info, the amount of search can be reduced.

DIGIT_LOWER = 1;
DIGIT_UPPER = 9;

n = (DIGIT_LOWER:DIGIT_UPPER).';

num = [];
den = [];

for i = DIGIT_LOWER:DIGIT_UPPER,
    numList = 10*n + i;
    denList = 10*i + n;
    
    for j = 1:length(numList),
        for k = 1:length(denList),
            value = numList(j) / denList(k);
            if (value < 1 && value == n(j) / n(k)),
                num = [num; numList(j)];
                den = [den; denList(k)];
            end;
        end;
    end;
end;

n1 = prod(num);
d1 = prod(den);

res = rat(d1 / n1)