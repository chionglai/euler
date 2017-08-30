
% q036

% number of palindrome base 10 digit (must be even)
nDigit = 6;


total = 0;

% for even length palindrome
eDigit = floor(nDigit/2);           % effective number of digit
endNum = 10^eDigit - 1;             % max of half of palimdrome

for i = endNum:-1:1,
    half = num2str(i);
        
    palinStr = [half, fliplr(half)];
    palin = str2double(palinStr);
    
    palinStr2 = dec2bin(palin);
    
    nPalinStr2 = length(palinStr2);
    nHalf = floor(nPalinStr2/2);
    
    % number in base 2 has even length
    half1 = palinStr2(1:nHalf);
    half2 = palinStr2((end-nHalf+1):end);
    
    if (strcmp(half1, fliplr(half2))),
        total = total + palin;
    end;
end;

% for odd length palindrome
eDigit = floor((nDigit - 1)/2);     % effective number of digit
endNum = 10^eDigit - 1;             % max of half of palimdrome

for i = endNum:-1:1,
    half = num2str(i);
    
    for j = 0:9,
        palinStr = sprintf('%s%d%s', half, j, fliplr(half));
        palin = str2double(palinStr);

        palinStr2 = dec2bin(palin);

        nPalinStr2 = length(palinStr2);
        nHalf = floor(nPalinStr2/2);

        % number in base 2 has even length
        half1 = palinStr2(1:nHalf);
        half2 = palinStr2((end-nHalf+1):end);

        if (strcmp(half1, fliplr(half2))),
            total = total + palin;
        end;
    end;
end;

% trivial case, single digit palindrome
for palin = 1:9,
    palinStr2 = dec2bin(palin);

    nPalinStr2 = length(palinStr2);
    nHalf = floor(nPalinStr2/2);

    % number in base 2 has even length
    half1 = palinStr2(1:nHalf);
    half2 = palinStr2((end-nHalf+1):end);

    if (strcmp(half1, fliplr(half2))),
        total = total + palin;
    end;
end;

res = total