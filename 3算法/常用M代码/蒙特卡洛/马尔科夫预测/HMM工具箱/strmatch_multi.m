function [posns] = strmatch_multi(keys, strs)
% STRMATCH_MULTI Find where each key occurs in list of strings.
% [pos] = strmatch_multi(key, strs) where key is a string and strs is a cell array of strings
% works like the built-in command sequence pos = strmatch(key, strs, 'exact'),
% except that pos is the first occurrence of key in strs; if there is no occurence, pos is 0.
%
% [posns] = strmatch_multi(keys, strs), where keys is a cell array of strings, 
% matches each element of keys. It loops over whichever is shorter, keys or strs.

if ~iscell(keys), keys = {keys}; end
nkeys = length(keys);
posns = zeros(1, nkeys);
if length(keys) < length(strs)
  for i=1:nkeys
    %pos = strmatch(keys{i}, strs, 'exact');
    ndx = strcmp(keys{i}, strs); % faster
    pos = find(ndx);
    if ~isempty(pos)
      posns(i) = pos(1);
    end
  end
else
  for s=1:length(strs)
    %ndx = strmatch(strs{s}, keys, 'exact');
    ndx = strcmp(strs{s}, keys);
    ndx = find(ndx);
    posns(ndx) = s;
  end
end

