function set_xtick_label(tick_labels, angle, axis_label)
% SET_XTICK_LABEL Print the xtick labels at an angle instead of horizontally
% set_xtick_label(tick_labels, angle, axis_label)
%
% angle default = 90
% axis_label default = ''
%
% This is derived from Solution Number: 5375 on mathworks.com
% See set_xtick_label_demo for an example

if nargin < 2, angle = 90; end
if nargin < 3, axis_label = []; end

% Reduce the size of the axis so that all the labels fit in the figure.
pos = get(gca,'Position');
%set(gca,'Position',[pos(1), .2, pos(3) .65])
%set(gca,'Position',[pos(1), 0, pos(3) .45])
%set(gca,'Position',[pos(1), 0.1, pos(3) 0.5])

ax = axis;    % Current axis limits
axis(axis);    % Fix the axis limits
Yl = ax(3:4);  % Y-axis limits

%set(gca, 'xtick', 1:length(tick_labels));
set(gca, 'xtick', 0.7:1:length(tick_labels));
Xt = get(gca, 'xtick');

% Place the text labels
t = text(Xt,Yl(1)*ones(1,length(Xt)),tick_labels);
set(t,'HorizontalAlignment','right','VerticalAlignment','top', 'Rotation', angle);

% Remove the default labels
set(gca,'XTickLabel','')

% Get the Extent of each text object.  This
% loop is unavoidable.
for i = 1:length(t)
  ext(i,:) = get(t(i),'Extent');
end

% Determine the lowest point.  The X-label will be
% placed so that the top is aligned with this point.
LowYPoint = min(ext(:,2));

% Place the axis label at this point
if ~isempty(axis_label)
  Xl = get(gca, 'Xlim');
  XMidPoint = Xl(1)+abs(diff(Xl))/2;
  tl = text(XMidPoint,LowYPoint, axis_label, 'VerticalAlignment','top', ...
	    'HorizontalAlignment','center');
end
