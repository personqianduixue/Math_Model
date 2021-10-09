function bipartiteMatchingDemoPlot(sources, detections, a)

hold on
p1 = size(sources,2);
p2 = size(detections,2);
for i=1:p1
  h=text(sources(1,i), sources(2,i), sprintf('s%d', i));
  set(h, 'color', 'r');
end
for i=1:p2
  h=text(detections(1,i), detections(2,i), sprintf('d%d', i));
  set(h, 'color', 'b');
end

if nargin < 3, return; end

for i=1:p1
  j = a(i);
  if j==0 % i not matched to anything
    continue
  end
  line([sources(1,i) detections(1,j)], [sources(2,i) detections(2,j)])
end
axis_pct;
