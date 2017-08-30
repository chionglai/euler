

% function: palinLargest.m
% purpose: get the largest palindrome with nDigit whose two factors are
%   both nDigit/2.
% input:
%   nDigit = number of digit for palindrome. Must be an even number.
% output:
%   palin = The palindrome.
%   y     = The prime factors for the palindrome
function [palin, y] = palinLargest(nDigit)

eDigit = nDigit/2;          % effective number of digit
endNum = 10^eDigit - 1;     % max of half of palindrome
startNum = 10^(eDigit - 1); % min of half palindrome. Need nDigit palindrome.

%% improved method
for i = endNum:-1:startNum,
    half = num2str(i);
    
    palinStr = [half, fliplr(half)];
    palin = str2double(palinStr);
    
    % factor1 will return all factors.
    fac = factor1(palin);
    
    % remove the trivial factor. Prime number will results in empty fac
    % after removal.
    fac([1, end]) = [];
    
    if (~isempty(fac)),
        % fac will always has even length
        nDigitFac = ceil(log10(fac));
        for j = 1:(length(fac)/2),
            if (sum(nDigitFac([j; end-j+1]) == eDigit) == 2),
                y = fac([j; end-j+1]);
                return;
            end;
        end;
    end;
end;


%% Version 1
% for i = endNum:-1:1,
%     half = sprintf(['%0', num2str(eDigit), 'd'], i);
%     
%     palin = str2num([half, fliplr(half)]);
%     y = prodSplit(palin);
%     
%     oriIdx = 1:length(y);
%     
%     % find combination of factors to produce factor with 3 digits
%     for j = 2:(length(y) - 1),
%         combi = nchoosek(oriIdx, j);
%         
%         for k = 1:size(combi, 1),
%             idx1 = combi(k, :);
%             prod1 = prod(y(idx1));
%             
%             idx2 = setdiff(oriIdx, idx1);
%             prod2 = prod(y(idx2));
%             
%             if (sum(ceil(log10([prod1, prod2])) > eDigit) == 0),
%                 return;
%             end;
%         end;
%     end;    
% end;