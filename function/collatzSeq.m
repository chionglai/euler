function y = collatzSeq( x, fn )
%GETCOLLATZSEQ Summary of this function goes here
%   Detailed explanation goes here

y = x;
while(x > 1),
    if (mod(x, 2) == 0),
        % x is even
        x = x/2;
    else
        % x is odd
        x = 3*x + 1;
    end;
    
    y = [y; x];
end;

end

