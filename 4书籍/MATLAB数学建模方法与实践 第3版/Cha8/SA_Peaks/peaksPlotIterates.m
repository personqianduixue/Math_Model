function varargout = peaksPlotIterates(varargin)
% Output function that plots the iterates of the optimization algorithm.

%  Copyright (c) 2010, The MathWorks, Inc.
%  All rights reserved.

% Check if caller is from global or optimization toolbox
optimValues = varargin{2};
state = varargin{3};
if nargout > 1
    if isfield(optimValues,'x') % simulated annealing options,optimvalues,flag
        x = optimValues.x;
        varargout{1} = false;
        varargout{2} = x; % options field
        varargout{3} = false;
    else % pattern search optimvalues,options,flag,interval
        optimValues = varargin{1};
        state = varargin{3};
        if isfield(optimValues,'x')
            x = optimValues.x;
            varargout{1} = false;
            varargout{2} = x; % options field
            varargout{3} = false;
        else % gentic algorithm options,state,flag,interval
            x = varargin{2}.Population;
            optimValues.iteration = -1;
            varargout{1} = varargin{2};
            varargout{2} = varargin{1};
            varargout{3} = false;
        end
    end
else
    x = varargin{1};
    varargout{1} = false;
end

% Check for state
switch state
    case 'init'
        % Plot objective function surface
        PlotSurface(x,peaks(x(:,1),x(:,2)));
    case 'iter'
        if ~(optimValues.iteration == 0)
            % Update surface plot to show current solution
            PlotUpdate(x,peaks(x(:,1),x(:,2)));
        end
    case 'done'
        if ~(optimValues.iteration == 0)
            % After optimization, display solution in plot title
            DisplayTitle(x,peaks(x(:,1),x(:,2)))
        end
end

% -------------------------------------------------------------------------
% helper function PlotSurface
% -------------------------------------------------------------------------
function PlotSurface(x,z,varargin)

% Check to see if figure exists, if not create it
h = findobj('Tag','PlotIterates');
if isempty(h)
    h = figure('Tag','PlotIterates','Name','Plot of Iterates', ...
        'NumberTitle','off');
    
    % Plot the objective function
    [X,Y,Z] = peaks(100);
    zlower = -15;
    axis([-3 3 -3 3 zlower 10]);
    hold on
    surfc(gca,X,Y,Z,'EdgeColor','None','FaceColor','interp')
    xlabel('X'), ylabel('Y'), zlabel('Z')
    view([-45 30])
    shading interp
    lightangle(-45,30)
    set(findobj(gca,'type','surface'),...
        'FaceLighting','phong',...
        'AmbientStrength',.3,'DiffuseStrength',.8,...
        'SpecularStrength',.9,'SpecularExponent',25,...
        'BackFaceLighting','unlit');
    
    % Plot constraint on lower contour plot
    hc=0; k=0; r=3; N=256; % circle parameters
    t=(0:N)*2*pi/N;
    xc = r*cos(t)+hc;
    yc = r*sin(t)+k;
    
    % bounds
    ax = axis;%.*[1.1 1.1 1.1 1.1 1 1]; 
    xbound = ( ax(1):(ax(2)-ax(1))/N*4:ax(2) )';
    ybound = ( ax(3):(ax(4)-ax(3))/N*4:ax(4) )';
    len = length(xbound);
    xbox = [xbound;  xbound(end)*ones(len-1,1);
            xbound(end-1:-1:1); xbound(1)*ones(len-2,1)]; 
    ybox = [ybound(1)*ones(len,1); ybound(2:end);
            ybound(end)*ones(len-1,1); ybound(end-1:-1:2)];
    
    boxCon = [(1:length(xbox)-1)' (2:length(ybox))'; length(xbox) 1];
    cirCon = [(1:length(xc)-1)' (2:length(yc))'; length(x) 1] + length(xbox);
    
    warning off
    DT = DelaunayTri([[xbox(:); xc(:)] [ybox(:); yc(:)]], [boxCon; cirCon]);
    warning on
    inside = inOutStatus(DT);
    cx = caxis;
    trisurf(DT(inside,:),DT.X(:,1),DT.X(:,2),...
           zlower*ones(size(DT.X(:,1))),'EdgeColor','none',...
           'FaceColor',[0.9 0.9 0.9]);
    caxis(cx)
    hold off
    
    % colors to use for multiple staring points
    ms.index = 1;
    ms.Colors = ['rgbcmyk'];
    set(h,'UserData',ms);
end

PlotUpdate(x,z)
if nargin > 2
    DisplayTitle(x,z,varargin{1})
else
    DisplayTitle(x,z,'Initial')
end

% -------------------------------------------------------------------------
% helper function PlotUpdate
% -------------------------------------------------------------------------
function PlotUpdate(x,z)

% Check to see if figure exists, if not, create
h = findobj('Tag','PlotIterates');
if isempty(h)
    PlotSurface(x,z,'Current')
    h = gcf;
end
% Update Plot with New Point
figure(h)
ms = get(h,'UserData');
hold on
spts = findobj('Tag','SurfacePoints');
if isempty(spts)
    spts = plot3(x(:,1),x(:,2),z*1.02,'MarkerFaceColor',ms.Colors(ms.index),...
        'MarkerSize',10,...
        'Marker','diamond',...
        'LineStyle','none',...
        'Color',ms.Colors(ms.index));
    set(spts,'Tag','SurfacePoints');
else
    set(spts, 'XData', [get(spts,'XData'),x(:,1)']);
    set(spts, 'YData', [get(spts,'YData'),x(:,2)']);
    set(spts, 'ZData', [get(spts,'ZData'),z']);
end

ax1 = findobj('Tag','LowerContour');
if isempty(ax1)
    if isvector(x)
        mk = '.-';
    else
        mk = '.';
    end
    ax1 = plot3(x(:,1),x(:,2),min(get(gca,'ZLim'))*ones(size(x(:,1))),...
        [ms.Colors(ms.index),mk],'MarkerSize',16);
    set(ax1,'Tag','LowerContour');
else
    set(ax1, 'XData', [get(ax1,'XData'),x(:,1)']);
    set(ax1, 'YData', [get(ax1,'YData'),x(:,2)']);
    set(ax1, 'ZData', [get(ax1,'ZData'),...
                       min(get(gca,'ZLim'))*ones(size(x(:,1)'))]);
end

DisplayTitle(x,z,'Current')

% -------------------------------------------------------------------------
% helper function DisplayTitle
% -------------------------------------------------------------------------
function DisplayTitle(x,z,varargin)
% colors to use for iterates

% Check to see if figure exists, if not, create
h = findobj('Tag','PlotIterates');
if isempty(h)
    PlotUpdate(x,z)
    h = gcf;
end

% Update Plot Title
if nargin < 3
    varargin{1} = 'Final';
end

ms = get(h,'UserData');
[mz,indx] = min(z);
switch lower(varargin{1})
    case 'current'
        str = 'Current';
    case 'initial'
        str = 'Initial';
        text(x(indx,1),x(indx,2),z(indx)*1.1,'\bf Start','Color',...
            ms.Colors(ms.index))
    case 'final'
        str = 'Final';
        text(x(indx,1),x(indx,2),z(indx)*1.1,'\bf End','Color',...
            ms.Colors(ms.index))
        ms.index = ms.index+1;
        set(h,'UserData',ms);
        ax1 = findobj('Tag','LowerContour');
        set(ax1,'Tag',['LowerContour',num2str(ms.index)]);
        spts = findobj('Tag','SurfacePoints');
        set(spts,'Tag',['SurfacePoints',num2str(ms.index)]);
end

str = sprintf('%s x = [%6.4f %6.4f]',str, x(indx,1),x(indx,2));
figure(h), title(str)
drawnow;

