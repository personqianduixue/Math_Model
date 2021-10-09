function out=plot_polygon(p, args, close_loop)
% PLOT_POLYGON
% function handle=plot_polygon(p, args, close_loop)
% p(1,i), p(2,i) are the x/y coords of point i.
% If non-empty, args are passed thru to the plot command.
% If close_loop = 1, connect the last point to the first 

% All rights reserved. Documentation updated April 1999.
% Matt Kawski. http://math.la.asu.edu/~kawski
% He calls it pplot

if nargin < 2, args = []; end
if nargin < 3, close_loop = 0; end

if close_loop
  p = [p p(:,1)];
end

if isempty(args)
   out=plot(p(1,:),p(2,:));
else   
   out=plot(p(1,:),p(2,:),args);
end
