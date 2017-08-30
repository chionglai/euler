
% purpose: given a number (radix)^power, find the sum of the digits of that
%          number.

function [tot, y] = sumDigit(radix, power)

r = radix;
p = power;

N = floor(p*log10(r)) + 1;   % number of digits
y = zeros(N, 1);

y(end) = r;
for pi = 2:p,
    y = y*r;
    
    %%% ALTERNATIVE
%     tens = 0;
%     for ki = N:-1:1,
%         y(ki) = y(ki) + tens;
%         if (y(ki) > 9),
%             tens = floor(y(ki)/10);
%             y(ki) = mod(y(ki), 10);
%         else
%             tens = 0;
%         end;
%     end;


    tens = [floor(y(2:end)/10); 0];
    y = mod(y, 10);
    y = y + tens;
    
    % repeat when there is carry after the sum
    ind = find(y > 9);
    if (~isempty(ind)),
        y(ind) = mod(y(ind), 10);
        y(ind-1) = y(ind-1)+1;
    end;
end;

tot = sum(y);
y = num2str(y).';

%% ALTERNATIVE
% two = sym('2');
% twotothousand = two^1000;
% str = char(twotothousand);
% sums = 0;
% for i=1:numel(str)
%     sums = sums + str2num(str(i));
% end
% display(sums);