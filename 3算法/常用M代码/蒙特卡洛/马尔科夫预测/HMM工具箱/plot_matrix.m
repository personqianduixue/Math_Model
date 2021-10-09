function plot_matrix(G, bw)
% PLOT_MATRIX Plot a 2D matrix as a grayscale image, and label the axes
%
% plot_matrix(M)
%
% For 0/1 matrices (eg. adjacency matrices), use
% plot_matrix(M,1)

if nargin < 2, bw = 0; end

if 0
  imagesc(G)
  %image(G)
  %colormap([1 1 1; 0 0 0]); % black squares on white background
  %colormap(gray)
  grid on
  n = length(G);
  
  % shift the grid lines so they don't intersect the squares
  set(gca,'xtick',1.5:1:n);
  set(gca,'ytick',1.5:1:n);
  
  % Turn off the confusing labels, which are fractional
  % Ideally we could shift the labels to lie between the axis lines...
%  set(gca,'xticklabel', []);
%  set(gca,'yticklabel', []);
else
  % solution provided by Jordan Rosenthal <jr@ece.gatech.edu>
  % You can plot the grid lines manually:
  % This uses the trick that a point with a value nan does not get plotted.
  imagesc(G);
  if bw
    colormap([1 1 1; 0 0 0]);
  end
  n = length(G);
  x = 1.5:1:n;
  x = [ x; x; repmat(nan,1,n-1) ];
  y = [ 0.5 n+0.5 nan ].';
  y = repmat(y,1,n-1);
  x = x(:);
  y = y(:);
  line(x,y,'linestyle',':','color','k');
  line(y,x,'linestyle',':','color','k');
  set(gca,'xtick',1:n)
  set(gca,'ytick',1:n)
end


