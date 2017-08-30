
% q045
% follow the same algorithm as q044

n = 143;

while(1),
    n = n + 1;
    hn = n*(2*n-1);
    
    % check for pentagonal
    nP = 1 + sqrt(1 + 24*hn);
    if (mod(nP, 6) == 0),
        nP = nP / 6;
        
        % check for triangle
        nT = -1 + sqrt(1 + 8*hn);
        if (mod(nT, 2) == 0),
            nT = nT / 2;
            break;
        end;
    end;
end;

fprintf('nT = %d, nP = %d, nH = %d, res = %d\n', nT, nP, n, hn);