function ndx = hash_del(key, fname)
% HASH_DEL Remove all entries that match key  from hashtable stored in a file
% ndx = hash_del(key, fname)
%
% Returns indices of matching entries (if any)
% See hash_lookup for an example

ndx = [];

if ~exist(fname, 'file')
  % new hashtable - no op
else
  %hashtable = importdata(fname);
  %hashtable = load(fname, '-mat');
  load(fname, '-mat');
  Nentries = length(hashtable.key);
  for i=1:Nentries
    if isequal(hashtable.key{i}, key)
      ndx = [ndx i];
    end
  end
  hashtable.key(ndx) = [];
  hashtable.value(ndx) = [];
  save(fname, 'hashtable', '-mat');
end

