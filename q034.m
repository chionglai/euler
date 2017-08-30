
% q034 - Similar to q030

tic;

%% determine the lower and upper limit of search
i = 1;
step = factorial(9);
upLim = step;
numDigit = i + 1;
while(i < numDigit),
    i = i + 1;
    upLim = upLim + step;
    
    numDigit = floor(log10(upLim)) + 1;
end;

lowLim = factorial(3);

%% Calculate
fact = factorial(0:9);

cand = ones(upLim, 1);
total = 0;
val = [];
for i = lowLim:upLim,
    % calculate sum of fifth power of digits
    ival = i;
    
    sumFac = 0;
    % 2nd ccondition. Whenever sumPow > i, we know that i is not a valid
    % val.
    while(ival > 0 && sumFac < i),
        sumFac = sumFac + fact(mod(ival, 10) + 1);
        ival = floor(ival/10);
    end;
    
    % found a valid value
    if (ival == 0 && i == sumFac),
        total = total + i;
        val = [val; i];
    end;
end;

toc;

res = total