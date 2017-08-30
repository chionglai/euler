
% q017

% one, two, three, ..., nine
one = [3; 3; 5; 4; 4; 3; 5; 5; 4];
% ten, eleven, twelve, ..., nineteen
spec = [3; 6; 6; 8; 8; 7; 7; 9; 8; 8];
% twenty, thirty, ... ninety
ten = [6; 6; 5; 5; 5; 7; 6; 6];
hundred = 7;
thousand = 8;
andWord = 3;

total = 0;
% 1. (1 -> 9), (21 -> 29), ..., (91 -> 99)
% a. the ones
total = total + 9*sum(one);
% b. the tens
total = total + 10*sum(ten);
% c. the special, (10 -> 19)
total = total + sum(spec);

% 2. same as a, but for over hundred
%                   one                 hundred      and        one
total = total + 100*sum(one) + 9 * (100*hundred + 99*andWord + total);

% 3. 1000
total = total + one(1) + thousand;

res = total