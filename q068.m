

N = 6;
n = (1:N).';
nHalf = N / 2;

A = eye(nHalf) + circshift(eye(nHalf), [0, 1]);
one = ones(nHalf, 1);

allX = nchoosek(1:N, nHalf).';

I = eye(nHalf);
nFlip = nchoosek(nHalf-1, 2);

for i = 1:size(allX, 2),
    x = allX(:, i);
    y = n;
    y(x) = [];
    xSort = sort(x);
    
    % a is correct
    a = xSort(1) + xSort(2) + y(end);
    
    II = I;
    
    % no flip
%     k = inv(II) * (a*one - A * x);
%     if (sum([k; x]) == sum(1:N)),
%         bsxfun(@times, A.', x);
%         %A*k + allM(:, i)
%         
%         [r, c] = find([II, A].');
%         xy = [k; x];
%         fprintf('%d, ', xy(r));
%         fprintf('\n');
%     end;
    
    % with flip
    k = inv(A) * (a*one - x);
    
    if (sum([k; x]) == sum(1:N) && sum(k > 0) == nHalf),
        disp('found');
    end;
    
    
    for j = 0:nFlip,
        II(1:(j+1), 1:(j+1)) = fliplr(II(1:(j+1), 1:(j+1)));
        Ak(1:(j+1), 1:(j+1)) = fliplr(Ak(1:(j+1), 1:(j+1)));
        k = (a*one - Ak * x);
    
        if (sum([k; x]) == sum(1:N)),
            %A*k + allM(:, i)
            
            [r, c] = find([II, A].');
            xy = [k; x];
            fprintf('%d, ', xy(r));
            fprintf('\n');
        end;
    end;
end;