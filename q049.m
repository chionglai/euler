
% q049

% number of digit (base 10)
nDigit = 4;

% number of occurrence
N = 3;

% range where the prime numbers are considered.
lim = [10^(nDigit-1), 10^nDigit - 1];

maxDiff = ceil(diff(lim)/2);

% assuming the 'prime.mat' contains all required prime numbers
load('D:\LCC\Matlab\#My functions\Prime number\prime.mat');

primeNum = prime(lim(1) <= prime & prime <= lim(2));
nPrime = length(primeNum);

% using Matlab hash-table
c = containers.Map;
for i = 1:nPrime,
    % convert to str
    str = num2str(primeNum(i));
    
    % sort each digit in ascending order to be used as hash-table key
    str = sort(str);
    
    % collect only
    % a. 4 unique digits
    if (length(str) == nDigit),
        % add entry to hash-table
        if (c.isKey(str)),
            c(str) = c(str) + 1;
        else
            c(str) = 1;
        end;
    else
        % flag prime number to be removed later
        primeNum(i) = 0;
    end;
end;

% remove prime numbers that fail the test
primeNum(primeNum == 0) = [];
nPrime = length(primeNum);

% find value with N occurrence
indices = find(cell2mat(c.values()) >= N);
keys = c.keys();

for i = 1:length(indices),
    idx = indices(i);
    
    % get its associated key    
    key = keys{idx};
    
    % permutate the key
    keyPerm = perms(key);
    keyPerm(keyPerm(:, 1) == '0', :) = [];
    
    % search list of prime numbers using regexp with the hash table key as
    % search pattern
    pat = sprintf('(%d)|', str2num(keyPerm(1:(end-1), :)));
    pat = [pat, '(', keyPerm(end, :), ')'];

    % convert reduced prime number list to arrays of cell of string for
    % regexp
    primeStr = num2str(primeNum);
    primeStr = mat2cell(primeStr, ones(nPrime, 1));
    
    % use regexp to find associated prime numbers
    numStr = regexp(primeStr, pat, 'match');
    
    % get the index of associated prime number
    idx = cellfun(@isempty, numStr);
    
    % get the prime numbers
    numStr = numStr(~idx);
    numStr = cellfun(@squeeze, numStr);
    
    % convert the prime numbers to integer
    num = str2num(cell2mat(numStr));
    nNum = length(num);
    
    for j = 1:(nNum-N+1),
        % get distance
        d = num - num(j);
        for k = (j+1):(nNum-N+2),
            if (d(k) <= maxDiff),
                hasSameMultiple = 1;
                nn = 1;
                while(hasSameMultiple && nn < N),
                    if (sum(d == nn*d(k)) == 0),
                        hasSameMultiple = 0;
                    end;
                    nn = nn + 1;
                end;

                if (hasSameMultiple),
                    startPrime = num(j)
                    multiple = d(k)
                    res = sprintf('%d', startPrime + (0:2).'*multiple)
                    break;
                end;
            end;
        end;
    end;
end;