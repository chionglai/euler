
% function: readArray.m
% purpose: read an array of integers from a readable text file (containing
%   only integers, separated by a commoon delimiters) and build an array
%   with each integer as the entry.
% input:
% ` fn = filename to the text file to read from.
%   delim = delimiter character to separate
%   r = Number of row to form the output array
%   c = Number of column to form the output array
% output:
%   y = array of integers read
function y = readArray( fn, delim, r, c )
fid = fopen(fn, 'r');
strFmt = sprintf('%%d%s', delim);
y = fscanf(fid, strFmt, Inf);
fclose(fid);

y = reshape(y, c, r).';

end

