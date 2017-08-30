
% q044

% Algorithm:
% First note that pentagonal nnumber is given by:
%       p(n) = n*(3*n - 1)/2, where n = 1, 2, ...
%
% Also note that for n >= 2, 
%       p(n) - p(n-1) = 3*(n-1) + 1,
% i.e.
%       p(n) - p(n-k) =   (3*(n-1) + 1) 
%                       + (3*(n-2) + 1) 
%                       + (3*(n-3) + 1) 
%                       + ...
%                       + ((3*(n-k) + 1))
%                     =   k*(3*n + 1)   (repeating constant term)
%                       - k*(k+1)/2     (aritmetic series)
% for (n-k) >= 1. With this, though the search is still O(N^2), the second
% (nested) search size can be reduced, i.e.
%
%   FOR n = 2:INF,
%       Calculate p(n)
%       
%       FOR k = 1:(n-1)
%           IF (p(n) - p(n-k)) is pentagonal
%               Calculate p(n-k). 
%               IF ( p(n) + p(n-k) ) is also pentagonal number
%                   BREAK;
%               ENDIF
%           ENDIF
%       ENDFOR
%   ENDFOR
%       

%% Pentagonal number index start with 1. n = 1 is trivial, so here I start
% with n = 2
j = 2;

D = 0;
while (~D),
    j = j + 1;
    pn = j*(3*j - 1)/2;     % pentagonal number for index n
    
    % initialise step to 0. Step is cummulative
    step = 0;
    for m = 1:(j-1),
        step = step + 3*(j-m) + 1;
        
        % check if step = p(n) - p(n-k) is pentagonal. Only check positive
        % root.
        % r = -b + sqrt(b^2 - 4*a*c), where b = -1, a = 3, c = -2*step
        % mod(x, 6) due to the denominator of 2*a, where a = 3
        if (mod(1 + sqrt(1 + 24*step), 6) == 0),
            % p(n-k) is also pentagonal
            pnmk = pn - step;
        
            % now need to check if p(n) + p(n-k) is also pentagonal. Only
            % check positive root.
            pSum = pn + pnmk;
            if (mod(1 + sqrt(1 + 24*pSum), 6) == 0),
                D = step;
                break;
            end;
        end;
    end;
end;

fprintf('j = %d, k = %d, res = D = %d\n', j, j-m, D);


% %% Very slow due to roots().
% % tolerance for double comparison
% tol = 1e-10;
% 
% % Pentagonal number index start with 1. n = 1 is trivial, so here I start
% % with n = 2
% j = 2394;
% 
% notFound = 0;
% while (~notFound),
%     j = j + 1;
%     pn = j*(3*j - 1)/2;     % pentagonal number for index n
%     
%     % initialise step to 0. Step is cummulative
%     step = 0;
%     for m = 1:(j-1),
%         step = step + 3*(j-m) + 1;
%         
%         % check if
%         rr = roots([3, -1, -2*step]);
%         r = rr(rr > 0);
%         if (~isempty(r) && abs(r - round(r)) <= tol),
%             % p(n-k) is also pentagonal
%             pnmk = pn - step;
%         
%             % now need to check if p(n) + p(n-k) is also pentagonal
%             pSum = pn + pnmk;
%             rr = roots([3, -1, -2*pSum]);
%             r = rr(rr > 0);
%             if (~isempty(r) && abs(r - round(r)) <= tol),
%                 notFound = 1;
%                 break;
%             end;
%         end;
%     end;
% end;
% 
% res = step