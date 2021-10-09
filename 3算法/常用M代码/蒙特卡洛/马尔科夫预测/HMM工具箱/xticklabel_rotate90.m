function xticklabel_rotate90(XTick,varargin)
%XTICKLABEL_ROTATE90 - Rotate numeric Xtick labels by 90 degrees
%
% Syntax: xticklabel_rotate90(XTick)
%
% Input:  XTick - vector array of XTick positions & values (numeric)
%
% Output:  none
%
% Example 1:  Set the positions of the XTicks and rotate them
%    figure;  plot([1960:2004],randn(45,1)); xlim([1960 2004]);
%    xticklabel_rotate90([1960:2:2004]);
%    %If you wish, you may set a few text "Property-value" pairs
%    xticklabel_rotate90([1960:2:2004],'Color','m','Fontweight','bold');
%
% Example 2:  %Rotate XTickLabels at their current position
%    XTick = get(gca,'XTick');
%    xticklabel_rotate90(XTick);
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: TEXT,  SET

% Author: Denis Gilbert, Ph.D., physical oceanography
% Maurice Lamontagne Institute, Dept. of Fisheries and Oceans Canada
% email: gilbertd@dfo-mpo.gc.ca  Web: http://www.qc.dfo-mpo.gc.ca/iml/
% February 1998; Last revision: 24-Mar-2003

if ~isnumeric(XTick)
   error('XTICKLABEL_ROTATE90 requires a numeric input argument');
end

%Make sure XTick is a column vector
XTick = XTick(:);

%Set the Xtick locations and set XTicklabel to an empty string
set(gca,'XTick',XTick,'XTickLabel','')

% Define the xtickLabels
xTickLabels = num2str(XTick);

% Determine the location of the labels based on the position
% of the xlabel
hxLabel = get(gca,'XLabel');  % Handle to xlabel
xLabelString = get(hxLabel,'String');

if ~isempty(xLabelString)
   warning('You may need to manually reset the XLABEL vertical position')
end

set(hxLabel,'Units','data');
xLabelPosition = get(hxLabel,'Position');
y = xLabelPosition(2);

%CODE below was modified following suggestions from Urs Schwarz
y=repmat(y,size(XTick,1),1);
% retrieve current axis' fontsize
fs = get(gca,'fontsize');

% Place the new xTickLabels by creating TEXT objects
hText = text(XTick, y, xTickLabels,'fontsize',fs);

% Rotate the text objects by 90 degrees
set(hText,'Rotation',90,'HorizontalAlignment','right',varargin{:})

%------------- END OF CODE --------------
