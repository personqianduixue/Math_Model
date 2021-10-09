function  varargout = partitionData(Ndata, varargin)
% PARTITIONDATA Partition a vector of indices into random sets
% [a,b,c,...] = partitionData(N, 0.3, 0.2, 0.5, ...)
%
% Examples:
% [a,b,c]=partitionData(105,0.3,0.2,0.5);
% a= 1:30, b=32:52, c=52:105 (last bin gets all the left over)

Npartitions = length(varargin);
perm = randperm(Ndata);
%perm = 1:Ndata;
ndx = 1;
for i=1:Npartitions
  pc(i) = varargin{i};
  Nbin(i) = fix(Ndata*pc(i));
  low(i) = ndx;
  if i==Npartitions
    high(i) = Ndata;
  else
    high(i) = low(i)+Nbin(i)-1;
  end
  varargout{i} = perm(low(i):high(i));
  ndx = ndx+Nbin(i);
end

