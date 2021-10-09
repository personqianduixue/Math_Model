function p = find_equiv_posns(vsmall, vlarge)
% FIND_EQUIV_POSNS p[i] = the place where vsmall[i] occurs in vlarge.
% p = find_equiv_posns(vsmall, vlarge)
% THE VECTORS ARE ASSUMED TO BE SORTED.
%
% e.g., vsmall=[2,8], vlarge=[2,7,8,4], p=[1,3]
%
% In R/S, this function is called 'match'
 
%if ~mysubset(vsmall, vlarge)
%  error('small domain must occur in large domain');
%end

if isempty(vsmall) | isempty(vlarge)
  p = [];
  return;
end
  
bitvec = sparse(1, max(vlarge)); 
%bitvec = zeros(1, max(vlarge));
bitvec(vsmall) = 1;
p = find(bitvec(vlarge));

%p = find(ismember(vlarge, vsmall)); % slower
