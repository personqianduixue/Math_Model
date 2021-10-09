function d = totaldistance(route, dis)
% TOTALDISTANCE
% d = TOTALDISTANCE(route, dis) calculate total distance of a route with
% the distance matrix dis.

d = dis(route(end),route(1)); % closed path
for k = 1:length(route)-1
    i = route(k);
    j = route(k+1);
    d = d + dis(i,j);
end