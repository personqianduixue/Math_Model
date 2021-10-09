% Consider matching sources to detections

%  s1 d2  
%         s2 d3
%  d1

%a  = bipartiteMatchingHungarian([52;0.01])

% sources(:,i) = [x y] coords
sources = [0.1 0.7; 0.6 0.4]';
detections = [0.2 0.2; 0.2 0.8; 0.7 0.1]';
dst = sqdist(sources, detections);

% a = [2 3] which means s1-d2, s2-d3
a = bipartiteMatchingHungarian(dst);
a2 = bipartiteMatchingIntProg(dst);
assert(isequal(a(:),a2(:)))


figure(1); clf
bipartiteMatchingDemoPlot(sources, detections, a)




%%%% Flip roles of sources and detections

%dst  = dst';
dst = sqdist(detections, sources);
% a = [0 1 2] which means d1-0, d2-s1, d3-s2
a = bipartiteMatchingHungarian(dst);

a2 = bipartiteMatchingIntProg(dst);
assert(isequal(a(:),a2(:)))

figure(2); clf
bipartiteMatchingDemoPlot(detections, sources, a) % swapped args




%%%%%%%%%% Move s1 nearer to d1
%  d2  
%         s2 d3
%  s1 d1

sources = [0.1 0.3; 0.6 0.4]';
detections = [0.2 0.2; 0.2 0.8; 0.7 0.1]';
dst = sqdist(sources, detections);

% a = [2 3] which means s1-d2, s2-d3
a = bipartiteMatchingHungarian(dst);
[a2, ass] = bipartiteMatchingIntProg(dst);
assert(isequal(a(:),a2(:)))


figure(3); clf
bipartiteMatchingDemoPlot(sources, detections, a)



%%%%%%%%%%

% Use random points

% Generate 2D data from a mixture of 2 Gaussians (from netlab demgmm1)
randn('state', 0); rand('state', 0);
gmix = gmm(2, 2, 'spherical');
ndat1 = 10; ndat2 = 10; ndata = ndat1+ndat2;
%gmix.centres =  [0.3 0.3; 0.7 0.7]; 
%gmix.covars = [0.01 0.01];
gmix.centres =  [0.5 0.5; 0.5 0.5];
gmix.covars = [0.1 0.01];
[x, label] = gmmsamp(gmix, ndata);

ndx = find(label==1);
sources = x(ndx,:)';
ndx = find(label==2);
detections = x(ndx,:)';
dst = sqdist(sources, detections);

[a, ass] = bipartiteMatchingIntProg(dst);
[a2] = bipartiteMatchingHungarian(dst);
assert(isequal(a(:), a2(:)))

figure(4); clf
bipartiteMatchingDemoPlot(sources, detections, a)

% only match 80% of points
p1 = size(sources, 2);
p2 = size(detections, 2);
nmatch = ceil(0.8*min(p1,p2));
a2 = bipartiteMatchingIntProg(dst, nmatch);
figure(5); clf
bipartiteMatchingDemoPlot(sources, detections, a2)


%%% swap roles

ndx = find(label==2);
sources = x(ndx,:)';
ndx = find(label==1);
detections = x(ndx,:)';
dst = sqdist(sources, detections);

% only match 80% of points
p1 = size(sources, 2);
p2 = size(detections, 2);
nmatch = ceil(0.8*min(p1,p2));
a2 = bipartiteMatchingIntProg(dst, nmatch);
figure(6); clf
bipartiteMatchingDemoPlot(sources, detections, a2)
