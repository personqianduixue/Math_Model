function bigT = mult_by_table(bigT, bigdom, bigsz, smallT, smalldom, smallsz)
% MULT_BY_TABLE 
% bigT = mult_by_table(bigT, bigdom, bigsz, smallT, smalldom, smallsz)
%

Ts = extend_domain_table(smallT, smalldom, smallsz, bigdom, bigsz);
bigT(:) = bigT(:) .* Ts(:); % must have bigT(:) on LHS to preserve shape
