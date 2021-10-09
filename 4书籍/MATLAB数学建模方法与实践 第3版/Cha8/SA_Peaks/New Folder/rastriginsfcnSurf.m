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

surfc(gca,X,Y,Z,'EdgeColor','None','FaceColor','interp')
xlabel('X'), ylabel('Y'), zlabel('Z')
view([-25 52])
shading interp
lightangle(-45,30)
set(findobj(gca,'type','surface'),...
    'FaceLighting','phong',...
    'AmbientStrength',.3,'DiffuseStrength',.8,...
    'SpecularStrength',.9,'SpecularExponent',25,...
    'BackFaceLighting','unlit');

