
% purpose: given a lower triangular matrix, find the path from top to base
%          of the triangular matrix whose sum along the path is maximum.
% input:
%   X -> a lower triangular matrix
%   
% outputs:
%   ymax -> maximum sum found
%   ypathI -> column index specifying the path taken from row 2 to row N to
%       get the maximum sum ymax
%   ypathV -> the value along the path ypathI.
%
function [ymax, ypathI, ypathV] = maxTri(X)

A = X;

N = length(A);

allPath = zeros(N);

for row = N:-1:2,
    % note: loop for column MUST be in increasing order. If not, then the
    % statement:
    %       allPath(row:end, col-1) = allPath(row:end, col);
    % may replace the value of allPath(row:end, col-1) (previous column),
    % which may still be needed when doing comparison for previous
    % columns!
    for col = 2:row,    
        if(A(row, col) > A(row, col-1)),
            allPath(row-1, col-1) = col;
            allPath(row:end, col-1) = allPath(row:end, col);
            A(row-1,col-1) = A(row-1,col-1) + A(row, col);
            
        else
            allPath(row-1, col-1) = col-1;
            A(row-1,col-1) = A(row-1,col-1) + A(row, col-1);
            
        end;
    end;
end;

ymax = A(1,1);
ypathI = allPath(1:(N-1), 1);
ypathV = zeros(N, 1);

ypathV(1) = X(1, 1);
for ni = 1:N-1,
    ypathV(ni+1) = X(ni+1, ypathI(ni));
end;
