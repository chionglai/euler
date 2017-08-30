
% q016

N = 1000;

% Must be less than N. To avoid overflow, use max 31, which correspond to int32.
kStep = 31;


x = int2dig(2^kStep);
tempDig = x;
mStep = kStep;
N = N - mStep;

%% The 3-stage approach is to speed things up in case N is very large
% First stage
while (N > mStep),
    tempDig = conv(tempDig, tempDig);
    N = N - mStep;
    mStep = 2*mStep;
    
    tempDig = correctDigit(tempDig);
end;

% Second stage
while (N > kStep),
    tempDig = conv(tempDig, x);
    N = N - kStep;
    
    tempDig = correctDigit(tempDig);
end;

% Third/Last stage
xLast = int2dig(2^N);
tempDig = conv(tempDig, xLast);
tempDig = correctDigit(tempDig);

res = sum(tempDig)