
% q032 - do not use. Too slow. Use python

DIGIT = '123456789';
MAX_DIGIT_FACTOR = 4;

tic;

aRes = [];
bRes = [];
cRes = [];
for i = MAX_DIGIT_FACTOR:-1:1,
    aCell = cellstr(nchoosek(DIGIT, i));
    aStrList = cell2mat(cellfun(@perms, aCell, 'UniformOutput', 0));
    aList = str2num(aStrList);
    
    for aIdx = 1:length(aList),
        a = aList(aIdx);
        existIdx = ismember(DIGIT, aStrList(aIdx, :));
        bDigit = DIGIT(~existIdx);
        
        for j = 1:(MAX_DIGIT_FACTOR - i + 1),
            bCell = cellstr(nchoosek(bDigit, i));
            bStrList = cell2mat(cellfun(@perms, aCell, 'UniformOutput', 0));
            bList = str2num(bStrList);
            
            for bIdx = 1:length(bList),
                b = bList(bIdx);
                existIdx = ismember(bDigit, bStrList(bIdx, :));
                remDigit = bDigit(~existIdx);
                
                product = a * b;
                
                prodStr = unique(num2str(product));
                
                if (length(prodStr) == length(remDigit) && all(ismember(remDigit, prodStr))),
                    aRes = [aRes; a];
                    bRes = [bRes; b];
                    cRes = [cRes; product];
                end;
            end;
        end;
    end;
end;

[cUni, ia, ~] = unique(cRes);
aUni = aRes(ia);
bUni = bRes(ia);

res = sum(cUni)

toc;

                    
                