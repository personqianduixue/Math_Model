function BG=grBase(E)
% Function BG=grBase(E) find all bases of digraph. 
% Input parameter: 
%   E(m,2) - the arrows of digraph;
%     1st and 2nd elements of each row is numbers of vertexes;
%     m - number of arrows.
% Output parameter:
%   BG(nb,nv) - the array with numbers of vertexes.
%     nb - number of bases;
%     nv - number of vertexes in each base.
%     In each row of the array BG is numbers 
%     of vertexes of this base.
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

[d,po]=grDecOrd(E); % decomposition
ngr=1; % numbers of groups
ua=po(1,:);
while ~all(ua),
  ung=find(~ua);
  ngr=[ngr ung(1)];
  ua=ua | po(ung(1),:);
end
levels=sum(d(:,ngr)); % full-factorial designs
ssize = prod(levels);
ncycles = ssize;
cols = length(levels);
design = zeros(ssize,cols);
for k = 1:cols
  settings = (1:levels(k));
  ncycles = ncycles./levels(k);
  nreps = ssize./(ncycles*levels(k));
  settings = settings(ones(1,nreps),:);
  settings = settings(:);
  settings = settings(:,ones(1,ncycles));
  design(:,k) = settings(:);
end
for k=1:size(design,2), % we change
  ff=find(d(:,ngr(k))); % number of factor
  BG(:,k)=ff(design(:,k)); % to number of vertex
end
return