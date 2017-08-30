
% function: readChar.m
% purpose: Read each digit from a readable text (containing numeric digits
%   only) and build an array with each digit as its entry.
% input:
%   fn = filename to read from.
% output:
%   y = array containing all the digits in int.
function y = readChar( fn )
fid = fopen(fn, 'r');
% lines = fgetl(fid);
[digits, count] = fscanf(fid, '%s');
fclose(fid);

digits = digits(:);

num = str2num(digits);

y = reshape(num, length(digits)/count, count).';
end

