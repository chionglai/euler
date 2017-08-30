
% q022

% read from file
fn = 'q022_data.txt';

fid = fopen(fn, 'r');
str = fscanf(fid, '%s');
fclose(fid);

% remove delimiters and only gets the names
pat = '\w+';
names = regexp(str, pat, 'match');

% as pre-caution
names = upper(names(:));

% sort in lexicographical order
nameSort = sort(names);

offset = 'A' - 1;

% Using loop
scoreTotal = 0;
for i = 1:length(nameSort),
    scoreTotal = scoreTotal + sum(nameSort{i} - offset)*i;
end;

res = scoreTotal

% Using vector operation: not working yet
% nameRank = (1:length(nameSort)).';
% nameScore = cellfun(@sum, nameSort);
% 
% score = nameRank.*nameScore;
% 
% scoreTotal = sum(score);
% res = scoreTotal
