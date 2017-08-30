
% To demo BigInt

%% Create test vectors
N = 1e2;
aSize = [2, 3];
bSize = [3, 4];
cSize = [2, 3];
dSize = [1, 1];

A = randi(N, aSize);
B = randi(N, bSize);
C = randi(N, cSize);
D = randi(N, dSize);

% generate matrix of BigInt
aBI(aSize) = BigInt;
for i = 1:aSize(1),
    for j = 1:aSize(2),
        aBI(i, j) = BigInt(num2str(A(i, j)));
    end;
end;

bBI(bSize) = BigInt;
for i = 1:bSize(1),
    for j = 1:bSize(2),
        bBI(i, j) = BigInt(num2str(B(i, j)));
    end;
end;

cBI(cSize) = BigInt;
for i = 1:cSize(1),
    for j = 1:cSize(2),
        cBI(i, j) = BigInt(num2str(C(i, j)));
    end;
end;

dBI(dSize) = BigInt;
for i = 1:dSize(1),
    for j = 1:dSize(2),
        dBI(i, j) = BigInt(num2str(D(i, j)));
    end;
end;

%% Test plus
Y = A + C;
yBI = aBI + cBI;

Y(:)
{yBI.Value}.'

%% Test minus
Y = A - C;
yBI = aBI - cBI;

Y(:)
{yBI.Value}.'

%% Test uminus
Y = -C;
yBI = -cBI;

Y(:)
{yBI.Value}.'

%% Test times
Y = A .* C;
yBI = aBI .* cBI;

Y(:)
{yBI.Value}.'

%% Test times with scalar
Y = A .* D;
yBI = aBI .* dBI;

Y(:)
{yBI.Value}.'

Y = D .* C;
yBI = dBI .* cBI;

Y(:)
{yBI.Value}.'


%% Test mtimes
Y = A * B;
yBI = aBI * bBI;

Y(:)
{yBI.Value}.'

%% Test mtimes with scalar
Y = A * D;
yBI = aBI * dBI;

Y(:)
{yBI.Value}.'

Y = D * B;
yBI = dBI * bBI;

Y(:)
{yBI.Value}.'

%% Test power
Y = A .^ C;
yBI = aBI .^ C;

Y(:)
aa = {yBI.Value}.'

%% Test power with scalar
Y = A .^ D;
yBI = aBI .^ D;

Y(:)
aa = {yBI.Value}.'

Y = D .^ B;
yBI = dBI .^ B;

Y(:)
aa = {yBI.Value}.'

%% Test mpower with scalars
Y = D ^ D;
yBI = dBI ^ D;

Y(:)
aa = {yBI.Value}.'
