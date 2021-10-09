function [h, ht] =plotBox(box, col, str)
% function h=plotBox(box, col, str)
%
% box = [xlow xhigh ylow yhigh]
% col = color (default - red)
% str = string printed at center (default '')

if nargin < 2, col = 'r'; end
if nargin < 3, str = ''; end

box = double(box); % fails on single

h = plot([box(1) box(2) box(2) box(1) box(1)], [ box(3) box(3) box(4) box(4) box(3)]);
set(h, 'color', col);
set(h, 'linewidth', 2);
if ~isempty(str)
  xc = mean(box(1:2));
  yc = mean(box(3:4));
  ht = text(xc, yc, str);
else
  ht = [];
end
