function ax = axis_pct(pct)
% AXIS_PCT       Set reasonable axis limits.
% AXIS_PCT(pct) sets axis limits to extend pct% beyond limits of plotted 
% objects.  Default is 5%.
% Works for linear or log scale.
% Unfortunately, the axes won't change when new points are plotted.

if nargin < 1
  pct = 0.05;
end
ax = [Inf -Inf Inf -Inf Inf -Inf];

% find bounding box of plotted objects
children = get(gca,'children');
for child = children'
  if strcmp(get(child,'type'),'text')
    xyz = get(child,'position');
    % need to determine bounding box of the text
    c([1 2]) = xyz(1);
    c([3 4]) = xyz(2);
    c([5 6]) = xyz(3);
  else
    x = get(child,'xdata');
    c(1) = min(x);
    c(2) = max(x);
    y = get(child,'ydata');
    c(3) = min(y);
    c(4) = max(y);
    z = get(child,'zdata');
    if isempty(z)
      c([5 6]) = 0;
    else
      c(5) = min(z);
      c(6) = max(z);
    end
  end
  ax([1 3 5]) = min(ax([1 3 5]), c([1 3 5]));
  ax([2 4 6]) = max(ax([2 4 6]), c([2 4 6]));
end
if strcmp(get(gca,'xscale'), 'log')
  ax([1 2]) = log(ax([1 2]));
end
if strcmp(get(gca,'yscale'), 'log')
  ax([3 4]) = log(ax([3 4]));
end
dx = ax(2)-ax(1);
if dx == 0
  dx = 1;
end
dy = ax(4)-ax(3);
if dy == 0
  dy = 1;
end
dz = ax(6)-ax(5);
if dz == 0
  dz = 1;
end
ax = ax + [-dx dx -dy dy -dz dz]*pct;
if strcmp(get(gca,'xscale'), 'log')
  ax([1 2]) = exp(ax([1 2]));
end
if strcmp(get(gca,'yscale'), 'log')
  ax([3 4]) = exp(ax([3 4]));
end
% clip for 2D
ax = ax(1:length(axis));
axis(ax);
if nargout < 1
  clear ax
end
