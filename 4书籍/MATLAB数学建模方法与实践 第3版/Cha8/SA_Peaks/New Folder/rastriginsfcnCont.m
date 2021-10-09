function rastriginsfcnSurf(numSamp,domLim)
% Oren Rosen
% The MathWorks
% 4/12/07

%  Copyright (c) 2010, The MathWorks, Inc.
%  All rights reserved.


if(nargin < 2)
    domLim = 5;
end
if(nargin < 1)
    numSamp = 100;
end

x = linspace(-domLim,domLim,numSamp);
y = linspace(-domLim,domLim,numSamp);
[X,Y] = meshgrid(x,y);
domain = [X(:),Y(:)];
Z = rastriginsfcn(domain);
Z = reshape(Z,numSamp,numSamp);

contour(X,Y,Z);

