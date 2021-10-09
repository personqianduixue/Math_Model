function [val, found, Nentries] = hash_lookup(key, fname)
% HASH_LOOKUP Lookup a key in a hash table stored in a file using linear search
% function [val, found, Nentries] = hash_lookup(key, filename)
%
% Example:
% If htbl.mat does not exist,
%   [val,found,N] = hash_lookup('foo', 'htbl')
% returns found val = [], found = 0, N = 0
%   hash_add('foo', 42, 'htbl')
%   hash_add('bar', [1:10], 'htbl')
%   [val,found,N] = hash_lookup('foo', 'htbl')
% now returns val = 42, found = 1, N = 2
%
% Type 'delete htbl' to delete the file/ reset the hashtable


val = [];
found = 0;

if exist(fname, 'file')==0
  % new hashtable
  Nentries = 0;
else
  %hashtable = importdata(fname);
  load(fname);
  Nentries = length(hashtable.key);
  for i=1:Nentries
    if isequal(hashtable.key{i}, key)
      val = hashtable.value{i};
      found = 1;
      break;
    end
  end
end
