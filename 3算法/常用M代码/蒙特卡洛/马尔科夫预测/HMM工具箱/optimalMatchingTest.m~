% Consider matching sources to detections

%  s1 d2  
%         s2 d3
%  d1

a  = optimalMatching([52;0.01])

% sources(:,i) = [x y] coords
sources = [0.1 0.7; 0.6 0.4]';
detections = [0.2 0.2; 0.2 0.8; 0.7 0.1]';
dst = sqdist(sources, detections)

% a = [2 3] which means s1-d2, s2-d3
a = optimalMatching(dst)

% a = [0 1 2] which means d1-0, d2-s1, d3-s2
a = optimalMatching(dst')
