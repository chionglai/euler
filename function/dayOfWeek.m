function day = dayOfWeek( date, month, year )
%DAYOFWEEK Get the day of week for a given date, month and year.

% Based on the algorithm:
% Another variation of the above algorithm likewise works with no lookup tables. A slight disadvantage is the unusual month and year counting convention. The formula is
% w = (d + \lfloor 2.6m - 0.2 \rfloor + y + \left\lfloor\frac{y}{4}\right\rfloor + \left\lfloor\frac{c}{4}\right\rfloor - 2c) \bmod 7,
% where
% Y is the year minus 1 for January or February, and the year for any other month
% y is the last 2 digits of Y
% c is the first 2 digits of Y
% d is the day of the month (1 to 31)
% m is the shifted month (March=1,...,February=12)
% w is the day of week (0=Sunday,...,6=Saturday)

% constant
days = {'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'};
daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
startYear = 1900;

% argument checking
if (month < 1 || month > 12),
    error('dayOfWeek: Month must be between 1 to 12 inclusive.');
end;

if (year < startYear),
    error('dayOfWeek: Year must be %d or later.', startYear);
end;

if (   (mod(year, 100) == 0 && mod(year, 400) == 0) ...    % year is century and divisible by 400
    || (mod(year, 100) ~= 0 && mod(year, 4) == 0)   ...    % year is not century and divisible by 4
   ),
    daysInMonth(2) = daysInMonth(2) + 1;
end;

if (date < 1 || date > daysInMonth(month)),
    error('dayOfWeek: Invalid date given. Valid date is 1 - %d inclusive.', ...
          daysInMonth(month));
end;

if (1 <= month && month <= 2),
    year = year - 1;
end;

d = date;
m = month - 2;
if (m < 0),
    m = m + 12;
end;
y = mod(year, 100);
c = floor(year/100);
w = mod(d + floor(2.6*m - 0.2) + y + floor(y/4) + floor(c/4) - 2*c, 7);

day = days{w + 1};
end

