function popDist = totaldistance(pop,dis)
% TOTALDISTANCE
% popDist = TOTALDISTANCE(pop, dis) calculate total distance of pop(routes)
% with the distance matrix dis. Evaluate Each Population Member (Calculate 
% Total Distance)

[popSize, numberofcities] = size(pop);
for i = 1:popSize
    d = dis(pop(i,end),pop(i,1)); % Closed Path
    for k = 2:numberofcities
        d = d + dis(pop(i,k-1),pop(i,k));
    end
    popDist(i) = d;
end