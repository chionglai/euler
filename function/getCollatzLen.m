function [y, collatzLen] = getCollatzLen(x, fn)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if (nargin < 2),
    fn = 'collatz.mat'; % default filename
end;

% flag to calculate new entries to table
hasNewEntry = 1;

if (exist(fn, 'file')),
    load(fn, 'collatzLen');
    
    if (x <= length(collatzLen)),
        hasNewEntry = 0;
    else
        startInd = length(collatzLen) + 1;
        collatzLen = [collatzLen; zeros(x-length(collatzLen), 1)];
    end;
    
else
    collatzLen = zeros(x, 1);
    collatzLen(1) = 1;           % trivial case for x = 1
    startInd = 2;
end;

if (hasNewEntry),
    len = ceil(log2(startInd));
    idx = 2^len;
    while (idx <= x),
        len = len + 1;
        collatzLen(idx) = len;
        idx = idx*2;
    end;

    for i = startInd:x,
        if (collatzLen(i) == 0),
            fac = factor(i);
            
            % calculate the length for all factor of 2
            len = sum(fac == 2);

            % get non-power of 2 factor
            nP2Fac = prod(fac(fac ~= 2));
            
            if (collatzLen(nP2Fac) > 0),
                collatzLen(i) = len + collatzLen(nP2Fac);
            else
                seq = collatzSeq(i);
            
                nSeq = length(seq);
                for j = 1:nSeq,
                    if (seq(j) <= x && collatzLen(seq(j)) == 0),
                        collatzLen(seq(j)) = len + nSeq - j + 1;
                    end;
                end;
            end;
        end;
    end;
    save(fn, 'collatzLen');
end;

y = collatzLen(x);

end

