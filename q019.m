
% q019

month = 1:12;
year = 1901:2000;

total = 0;
for i = year,
    for j = month,
        d = dayOfWeek(1, j, i);
        if (strcmpi(d, 'sunday')),
            total = total + 1;
        end;
    end;
end;

res = total