function dis = distancematrix(city)
% DISTANCEMATRIX
% dis = DISTANCEMATRIX(city) return the distance matrix, dis(i,j) is the 
% distance between city_i and city_j

numberofcities = length(city);
R = 6378.137; % The radius of the Earth
for i = 1:numberofcities
    for j = i+1:numberofcities
        dis(i,j) = distance(city(i).lat, city(i).long, ...
                            city(j).lat, city(j).long, R);
        dis(j,i) = dis(i,j);
    end
end


function d = distance(lat1, long1, lat2, long2, R)
% DISTANCE
% d = DISTANCE(lat1, long1, lat2, long2, R) compute distance between points
% on sphere with radians R.
%
% Latitude/Longitude Distance Calculation:
% http://www.mathforum.com/library/drmath/view/51711.html
 
y1 = lat1/180*pi; x1 = long1/180*pi;
y2 = lat2/180*pi; x2 = long2/180*pi;
dy = y1-y2; dx = x1-x2;
d = 2*R*asin(sqrt(sin(dy/2)^2+sin(dx/2)^2*cos(y1)*cos(y2)));
