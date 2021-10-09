% initFigures
% Position 6 figures on the edges of the screen.
% [xmin ymin w h] where (0,0) = bottom left
% Numbers assume screen resolution is 1024 x 1280

global FIGNUM NUMFIGS
FIGNUM = 1; NUMFIGS = 6;

screenMain = true; % set to false if initializing figures for second screen
%screenMain = false;

if screenMain
  xoff = 0; 
else
  %xoff = 1280;
  xoff = -1280;
end

% 2 x 3 design
w = 400; h = 300;
xs = [10 450 875] + xoff;
ys = [650 40];

if 0
% 3x3 design
w = 350; h = 250;
xs = [10 380 750]+xoff;
ys = [700 350 10];
end


Nfigs = length(xs)*length(ys);
if screenMain
  fig = 1; 
else
  fig = Nfigs + 1;
end

for yi=1:length(ys)
  for xi=1:length(xs)
    figure(fig);
    set(gcf, 'position', [xs(xi) ys(yi) w h]);
    fig = fig + 1;
  end
end

% To plot something on the next available figure (with wrap around), use
% sfigure(FIGNUM); clf; FIGNUM = wrap(FIGNUM+1, NUMFIGS); 
