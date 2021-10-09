function f = previewfig(h,varargin)
%PREVIEWFIG  Preview a figure to be exported using EXPORTFIG.
%   F = PREVIEWFIG(H) creates a preview of H with the default
%   EXPORTFIG options and returns the preview's figure handle in F.
%   F = PREVIEWFIG(H,OPTIONS) creates a preview with OPTIONS as
%   described in EXPORTFIG.
%   PREVIEWFIG(...,PARAM1,VAL1,PARAM2,VAL2,...) creates a preview
%   with the specified parameter-value pairs to H as described in
%   EXPORTFIG. 
%
%   See also EXPORTFIG, APPLYTOFIG, RESTOREFIG.

%  Copyright 2000 Ben Hinkle
%  Email bug reports and comments to bhinkle@mathworks.com

filename = [tempname, '.png'];
args = {'resolution',0,'format','png'};
if nargin > 1
  exportfig(h, filename, varargin{:}, args{:});
else
  exportfig(h, filename, args{:});
end

X = imread(filename,'png');
height = size(X,1);
width = size(X,2);
delete(filename);
f = figure( 'Name', 'Preview', ...
	    'Menubar', 'none', ...
	    'NumberTitle', 'off', ...
	    'Visible', 'off');
image(X);
axis image;
ax = findobj(f, 'type', 'axes');
axesPos = [0 0 width height];
set(ax, 'Units', 'pixels', ...
	'Position', axesPos, ...
	'Visible', 'off');
figPos = get(f,'Position');
rootSize = get(0,'ScreenSize');
figPos(3:4) = axesPos(3:4);
if figPos(1) + figPos(3) > rootSize(3)
  figPos(1) = rootSize(3) - figPos(3) - 50;
end
if figPos(2) + figPos(4) > rootSize(4)
  figPos(2) = rootSize(4) - figPos(4) - 50;
end
set(f, 'Position',figPos, ...
       'Visible', 'on');
