function colors = hsvKPM(N)
% hsvKPM Like built-in HSV, except it randomizes the order, so that adjacent colors are dis-similar
% function colors = hsvKPM(N)

colors = hsv(N);
perm = randperm(N);
colors = colors(perm,:);
