function y=logsum(x,d)
%LOGSUM logsum(x,d)=log(sum(exp(x),d))
%  d gives dimension to sum along

%      Copyright (C) Mike Brookes 1998
%
%      Last modified Mon Oct 12 15:47:25 1998
%
%   VOICEBOX is a MATLAB toolbox for speech processing. Home page is at
%   http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html
%

if nargin==1
   d=[find(size(x)-1) 1];
   d=d(1);
end
n=size(x,d);
if n<=1, y=x; return; end
s=size(x);
p=[d:ndims(x) 1:d-1];
z=reshape(permute(x,p),n,prod(s)/n);

y=max(z);
y=y+log(sum(exp(z-y(ones(n,1),:))));

s(d)=1;
y=ipermute(reshape(y,s(p)),p);

