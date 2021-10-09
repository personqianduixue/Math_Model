function [lh, th] = bubbleplot(x, y, z, siz, col, shape, varargin)
% BUBBLEPLOT produces a scatter plot that enables the visualization of upto 
% 6-dimensional data. The dimensions used for displaying data include the 
% X, Y and Z coordinates, the marker size, color and shape. 
%
% USAGE: 
% BUBBLEPLOT(x, y, z, siz, col, shape)
%    draws a 3D bubble plot. See input parameter description below.
%
% BUBBLEPLOT(x, y, [], siz, col, shape)
%    draws a 2D bubble plot. 
%
% BUBBLEPLOT(..., textarray)
%    enables you to pass in a cell array of strings to annotate each point
%    on the plot. By default the strings are displayed as text labels as well
%    as stored in the UserData property of the line objects
%
% BUBBLEPLOT(..., textarray, 'ShowText', false)
%    will not display the text on screen, but will store it in the user
%    data property. This can be useful when creating a custom data tip.
%
% [hLine, hText] = BUBBLEPLOT(...)
%    returns a vector of line handles to the points in the plot and 
%    (if appropriate) a vector of handles to the text objects on the
%    screen.
%
% INPUT PARAMETERS:
% The inputs should be vectors of the same length, with the following
% requirements:
%  Input     Required     Default-Value         Type
% x, y, z      Yes             N/A          Numerical (Continuous or discrete)
%   siz         No              8           Numerical (Continuous or discrete)
%   col         No           col = z        Numerical or Categorical*
%  shape        No             'o'          Categorical* (upto 13 unique discrete values)
% 
% NOTES:
% * "Categorical" variables can either be numeric with discrete values or
%   non-numeric data types that support a "UNIQUE" method. Examples of this
%   can be a cell array of strings, a nominal array or ordinal array.
%
% * The siz variable is normalized to a marker size range of 3 to 20. To
%   specify a custom size range use the optional parameter
%   'markerSizeLimits'. Example: BUBBLEPLOT(..., 'MarkerSizeLimits', [5 32])
%
% * The shape variable can also be a character that represents a marker
%   shape to be used for all points
%
% * If col is a categorical variable, ensure it is integer-valued so that
%   it is handled correctly. If it is not integer valued, BUBBLEPLOT will
%   check to see if the number of unique values is less than 10% of the
%   length of the vector and use that to determine if the variable is
%   categorical. The colors used to depict categorical data are evenly
%   spaced (1 color level per unique category/label). However if col is
%   not categorical, its values are simply scaled to different values in
%   the colormap
%
% * The default font size used to display the text labels is 8 pt with a
%   left alignment. Use the input arguments 'FontSize' and 'Alignment' to
%   control these properties.
%   Example: BUBBLEPLOT(..., 'FontSize', 6, 'Alignment', 'center')
%
% * You can specify a custom colormap using the Colormap argument. The
%   parameter can be a string (eg. 'cool'), a function handle (eg. @jet) or 
%   an N-by-3 matrix of color RGB levels.
%   Example: BUBBLEPLOT(..., 'ColorMap', cmap)

% Copyright 2014 The MathWorks, Inc.
%% Parse input params and defaults

% Check number of input arguments
error(nargchk(2,10,nargin,'struct'));

% Default z
if nargin < 3
    z = [];
end

% Default size
if nargin < 4 || isempty(siz)
    siz = 8;
end

if nargin < 5 || isempty(col)
    col = z;
end

if nargin < 6 || isempty(shape)
    shape = 'o';
end

p = inputParser;
p.addOptional('Text',{},@(x)iscellstr(x)||(ischar(x)&&size(x,1)>1)||(~ischar(x)&&length(x)>1));
p.addParamValue('ShowText',true);
p.addParamValue('FontSize',8);
p.addParamValue('Alignment', 'left');
p.addParamValue('MarkerSizeLimits',[3 20]);
p.addParamValue('ColorMap',@cool);
p.parse(varargin{:});
desctext = p.Results.Text;
showText = p.Results.ShowText;
fontSize = p.Results.FontSize;
alignment = p.Results.Alignment;
colmapfun = p.Results.ColorMap;
markerSizeLimits = p.Results.MarkerSizeLimits;

%% Determine marker colors
if ischar(colmapfun)
    colmapfun = str2func(colmapfun);
elseif isnumeric(colmapfun)
    colmapfun = @(x)colmapfun(1:min(x,end),:);
end
    
if isempty(col)
    col = zeros(size(x));
end
[uniqueCols, gar, colInd] = unique(col);
if isinteger(col) || isa(col,'categorical') || iscell(col) || length(uniqueCols)<=.1*length(col) || all(round(col)==col) % Is col categorical
    % Generate a colormap with one level per unique entry in col
    colmap = colmapfun(length(uniqueCols));
else
    % Scale the color values to span the colormap
    colmap = colmapfun(128);
    x = max(col);
    n = min(col);
    if x == n, x = n + 1; end
    colInd = (col-n)/(x-n)*(size(colmap,1)-1)+1;
end
try
    color = colmap(colInd,:);
catch %#ok<CTCH>
    error('The custom colormap must have at least %d levels', max(colInd));
end

%% Determine marker shape
if ischar(shape)
    markertype = repmat(shape(1),size(x));
else
    markerseq = 'osd^><vph.*+x';
    [uniqueShapes, gar, shapeInd] = unique(shape);
    if length(uniqueShapes)>length(markerseq)
        error('BubblePlot can only support 13 unique shapes');
    end
    markertype = markerseq(shapeInd);
end

%% Determine marker size
if isscalar(siz)
    siz = repmat(siz, size(x));
    markersize = siz;
else % Map the siz variable to a markersize between a minimum and maximum
    minsize = markerSizeLimits(1);
    maxsize = markerSizeLimits(2);
    markersize = (siz - min(siz))/(max(siz)-min(siz))*(maxsize - minsize)+minsize;
end

%% Clean up data - handle NaNs
markersize(isnan(markersize)) = .01; % These will not be drawn as regular markers, just pixel points

%isnan(x) | isnan(y) | isnan(z) | isnan(col) | 


%% Plot data
% Create structure to store original data in every graphics object (for
% subsequent retrieval, eg: with data tip)

pointData = struct('x',num2cell(x),'y',num2cell(y),'siz',num2cell(siz),'col',num2cell(col),...
    'shape',num2cell(shape));

if nargin > 6 && ~isempty(desctext)
    if ~iscellstr(desctext)
        desctext = cellstr(desctext);
    end
    [pointData.text] = desctext{:};
end

if isempty(z)
    plotfun = @plot;
    zarg = {};
else
    plotfun = @plot3;
    zarg = {z(1)};
    zdata = num2cell(z);
    [pointData.z] = zdata{:};
end

lh = zeros(1,length(x)); % Line Handles
lh(1) = customPlot(plotfun, pointData(1), color(1,:), markersize(1), markertype(1), x(1), y(1), zarg{:});

for i = 2:length(lh)
    if isempty(z), zarg = {}; else zarg = {z(i)}; end
    lh(i) = customPlot(@line, pointData(i), color(i,:), markersize(i), markertype(i), x(i), y(i), zarg{:});
end

if showText
    hAxes = get(lh(1),'Parent');
    offset = diff(get(hAxes,'Ylim'))*.01;
    if isempty(z)
        z = zeros(size(x));
    end
    th = text(x, y-offset, z, desctext, 'Fontsize', fontSize, 'HorizontalAlignment', alignment);
    lims = get(hAxes,{'XLim','YLim','ZLim'});
    lims = vertcat(lims{:});
    factor = fontSize.*diff(lims,[],2);
    addlistener(hAxes,{'XLim','YLim'},'PostSet',@(obj,evdata)resizeText(hAxes, th, y, factor));
    %addlistener(get(hAxes,'Parent'),'Resize',@(obj,evdata)resizeText(hAxes, th));
else
    th = [];
end


function lh = customPlot(funh, pointData, c, siz, markertype, varargin)
lh = funh(varargin{:});
set(lh, 'Marker', markertype,...
    'LineStyle', 'none', 'Color', c, 'MarkerFaceColor', c, ...
    'MarkerEdgeColor', [0 0 0], 'MarkerSize', siz,...
    'UserData', struct('Point',pointData));

%     lh = patch('XData',x(i),'YData', y(i), 'ZData', z(i), 'Marker', 'o',...
%     'LineStyle', 'none', 'CData', color, 'MarkerFaceColor', c, ...
%     'MarkerEdgeColor', [0 0 0], 'MarkerSize', siz2(i), 'FaceAlpha', .4, 'EdgeAlpha', .2, ...
%     'UserData', data);

function resizeText(hAxes, hText, y, factor) %#ok<*INUSD>
lims = get(hAxes,{'XLim','YLim','ZLim'});
lims = vertcat(lims{:});
% Uncomment following to update fontsize
% newfs = min([factor(1:2)./diff(lims(1:2,:),[],2) ; 24]);
% set(hText,'FontSize',newfs);

% Update position
offset = diff(get(hAxes,'Ylim'))*.01;
p = get(hText,'Position');
p = vertcat(p{:});
outofbounds = any(bsxfun(@gt,p,lims(:,2)') | bsxfun(@lt,p,lims(:,1)'), 2);
set(hText(outofbounds),'Visible','off');
set(hText(~outofbounds),'Visible','on');

% Adjust offsets
p(:,2) = y - offset;
for i = 1:length(p)
    set(hText(i),'Position',p(i,:));
end


