
% q030

N = 5;  % fifth power

tic;

%% determine the lower and upper limit of search
i = 1;
step = 9^N;
upLim = step;
numDigit = i + 1;
while(i < numDigit),
    i = i + 1;
    upLim = upLim + step;
    
    numDigit = floor(log10(upLim)) + 1;
end;

lowLim = 2^N;

%% Calculate
pow5Table = (0:9).^N;

total = 0;
val = [];
for i = lowLim:upLim,
    % calculate sum of fifth power of digits
    ival = i;
    
    sumPow = 0;
    % 2nd ccondition. Whenever sumPow > i, we know that i is not a valid
    % val.
    while(ival > 0 && sumPow < i),
        sumPow = sumPow + pow5Table(mod(ival, 10) + 1);
        ival = floor(ival/10);
    end;
    
    % found a valid value
    if (ival == 0 && i == sumPow),
        total = total + i;
        val = [val; i];
    end;
end;

toc;

res = total