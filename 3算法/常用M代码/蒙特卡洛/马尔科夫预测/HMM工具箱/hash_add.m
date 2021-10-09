function hash_add(key, val, fname)
% HASH_ADD Append key,value pair to end of hashtable stored in a file
% function hash_add(key, val, filename)
%
% See hash_lookup for an example

if ~exist(fname, 'file')
  % new hashtable
  hashtable.key{1} = key;
  hashtable.value{1} = val;
else
  %hashtable = importdata(fname);
  %hashtable = load(fname, '-mat');
  load(fname, '-mat');
  Nentries = length(hashtable.key);
  hashtable.key{Nentries+1} = key;
  hashtable.value{Nentries+1} = val;
end
save(fname, 'hashtable', '-mat');
