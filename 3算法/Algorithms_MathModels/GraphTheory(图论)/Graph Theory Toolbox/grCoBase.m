function CBG=grCoBase(E)
% Function CBG=grCoBase(E) find all contrabases of digraph. 
% Input parameter: 
%   E(m,2) - the arrows of digraph;
%     1st and 2nd elements of each row is numbers of vertexes;
%     m - number of arrows.
% Output parameter:
%   CBG(ncb,nv) - the array with numbers of vertexes.
%     ncb - number of contrabasis;
%     nv - number of vertexes in each contrabasis.
%     In each row of the array BG is numbers 
%     of vertexes of this contrabasis.
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

E=E(:,[2 1]);
CBG=grBase(E);
return