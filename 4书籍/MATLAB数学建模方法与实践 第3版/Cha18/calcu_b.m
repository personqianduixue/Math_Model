function [ B ] = calcu_b( passengers,taxis )
invalid_lines = find(isnan(passengers(:,1)));
passengers(invalid_lines,:) = [];
%划分网格
area_d = zeros(9,14);%需
[h,w] = size(passengers);
for i = 1:h
    y = floor(passengers(i,1))+1;
    x = floor(passengers(i,2))+1;
    area_d(x,y) = area_d(x,y) + 1;
end
area_s = zeros(9,14);%供
[h,w] = size(taxis);
for i = 1:h
    y = floor(taxis(i,1))+1;
    x = floor(taxis(i,2))+1;
    area_s(x,y) = area_s(x,y) + 1;
end
%供需相等
s1 = sum(area_s(area_s == area_d));
d1 = sum(area_d(area_s == area_d));
%供大于求
s2 = sum(area_s(area_s > area_d));
d2 = sum(area_d(area_s > area_d));
%供小于求
s3 = sum(area_s(area_s < area_d));
d3 = sum(area_d(area_s < area_d));
d = d1+d2+d3;
if d3 == s3
    B = s1/d + s2/d;
    return
end
B = s1/d + s2/d + d3/d*d3/s3;
end

