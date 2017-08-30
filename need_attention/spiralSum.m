

% N must be odd!
function total = spiralSum(N)   

nn = (N+1)/2;

total = 1;
prev = 1;
for ni = 2:nn,
    d = 2*(ni-1);
    a = prev + d;
    
    prev = a+3*d;
    
    total = total + 2*(a + prev);  % second part is arithmetic series with 4 elements
end;