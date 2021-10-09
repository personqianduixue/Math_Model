function ndx = strmatch_substr(str, strs)
% STRMATCH_SUBSTR Like strmatch, except str can match any part of strs{i}, not just prefix.
% ndx = strmatch_substr(str, strs)
%
% Example:
% i = strmatch('max', {'max','minimax','maximum'})
%  returns i = [1; 3] since only 1 and 3 begin with max, but
% i = strmatch_substr('max', {'max','minimax','maximum'})
%  returns i = [1;2;3];
%
% If str is also a cell array, it is like calling strmatch_substr several times
% and concatenating the results. 
% Example:
% 
% i = strmatch_substr({'foo', 'dog'}, {'foo', 'hoofoo', 'dog'}) 
%   returns i = [1;2;3]

ndx = [];
if ~iscell(str), str = {str}; end
for j=1:length(str)
  for i=1:length(strs)
    %ind = strfind(strs{i}, str{j}); % not supported in 6.0
    ind = findstr(strs{i}, str{j});
    if ~isempty(ind)
      ndx = [ndx; i];
    end
  end
end
