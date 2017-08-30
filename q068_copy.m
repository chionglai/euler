

N = 6;
n = (1:N).';
nHalf = N / 2;

A = eye(nHalf) + circshift(eye(nHalf), [0, 1]);
one = ones(nHalf, 1);

allX = nchoosek(1:N, nHalf).';

I = eye(nHalf);
nFlip = nchoosek(nHalf-1, 2);

II = [[I, -one]; [ones(1, nHalf), 0]];
for i = 1:size(allX, 2),
    x = allX(:, i);
    y = n;
    y(x) = [];
    xSort = sort(x);
    
    a = xSort(1) + xSort(2) + y(end);
    
    % no flip
    k = inv(II) * [- A * x; sum(y)];
    if (sum([k(1:(end-1)); x]) == sum(n)),
        bsxfun(@times, A.', x)
        %A*k + allM(:, i)
        fprintf('%d, ', [k; x]);
        fprintf('\n');
    end;
    
    % with flip
    for j = 1:nFlip,
        Ak = A;
        Ak(j:end, j:end) = fliplr(Ak(j:end, j:end));
        k = a*one - Ak * x;
    
        if (sum([k; x]) == sum(1:N)),
            %A*k + allM(:, i)
            fprintf('%d, ', [k; x]);
            fprintf('\n');
        end;
    end;
end;