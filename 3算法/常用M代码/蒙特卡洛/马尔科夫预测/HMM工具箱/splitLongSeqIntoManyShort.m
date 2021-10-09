function short = splitLongSeqIntoManyShort(long, Tsmall)
% splitLongSeqIntoManyShort Put groups of columns  into a cell array of narrower matrices
% function short = splitLongSeqIntoManyShort(long, Tsmall)
%
% long(:,t)
% short{i} = long(:,ndx1:ndx2) where each segment (except maybe the last) is of length Tsmall

T = length(long);
Nsmall = ceil(T/Tsmall);
short = cell(Nsmall,1);

t = 1;
for i=1:Nsmall
  short{i} = long(:,t:min(T,t+Tsmall-1));
  t = t+Tsmall;
end
