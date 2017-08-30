
% q041
N = 7;  % Largest is 7-digit.

LOWER = 10^(N-1);
UPPER = 10^N;
digit = '123456789';

tic

p = genPrime(UPPER);
p = p(p > LOWER);

% pStr = cellstr(num2str(p));
% pUniStr = cellfun(@unique, pStr, 'UniformOutput', false);
% 
% pStrLen = cellfun(@length, pStr);
% pUniStrLen = cellfun(@length, pUniStr);
% 
% uniIdx = pStrLen == pUniStrLen;
% 
% pUniStr = pUniStr(uniIdx);
% 


for i = length(p):-1:1,
    str = num2str(p(i));
    uni = unique(str);
    
    if ((length(uni) == length(str)) && all(ismember(str, digit(1:length(str))))),
        fprintf('Found: result = %s\n', str);
        break;
    end;
end;

res = uint32(str);

toc

% p = y.';
% 
% nP = length(p);
% 
% for i = nP:-1:1,
%     pStr = num2str(p(i));
%     
%     uPStr = unique(pStr);
%     if (length(pStr) == length(uPStr)),
%         sUPStr = sort(uPStr);
%         yd = diff(str2num(sUPStr.'));
%         
%         if ((sUPStr(1) == '1') && (sum(yd) == (length(pStr) - 1))),
%             break;
%         end;
%     end;
% end;
% 
% res = pStr