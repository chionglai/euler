
% q012
N = 500;

ii = 1;
triNum = ii;
while(1),
    ii = ii + 1;
    triNum = triNum + ii;
    
    y = factor1(triNum);
    
    if (length(y) > N),
        break;
    end;
end;

res = triNum
