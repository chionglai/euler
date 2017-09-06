function y = collatzSeq( x )
%COLLATZSEQ Generate the Collatz sequence for a given positive integer. 
%   A Collatz sequence is as follows. 
%   1. start with any positive integer n. 
%   2. Then each term is obtained from the previous term as follows: 
%      a. if the previous term is even, the next term is one half the 
%         previous term. 
%      b. Otherwise, the next term is 3 times the previous term plus 1. 
%   3. Stop when the term reaches 1.

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

