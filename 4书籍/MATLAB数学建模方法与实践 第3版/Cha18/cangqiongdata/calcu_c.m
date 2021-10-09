function [ c,area_d,area_s ] = calcu_c( d,s )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
xrange = linspace(108.83,109.08,4);
yrange = linspace(34.1585,34.4047,4);
area_d = zeros(3,3);
area_s = zeros(3,3);
for i = 1:length(d)
    %ÅÐ¶Ïºá×ø±ê
    line = -1;col = -1;
    for j = 1:3
        if d(i,1)-xrange(j) <= 0.0833
            col = j;
            break
        end
    end
    %ÅÐ¶Ï×Ý×ø±ê
    for j = 1:3
        if d(i,2)- yrange(j) <= 0.0821
            line = 4 - j;
            break
        end
    end
    if line==-1 || col == -1
        continue
    end
    area_d(line,col) = area_d(line,col) + d(i,3);
end

for i = 1:length(s)
    line = -1;col = -1;
    %ÅÐ¶Ïºá×ø±ê
    for j = 1:3
        if s(i,1)-xrange(j) <= 0.0833
            col = j;
            break
        end
    end
    %ÅÐ¶Ï×Ý×ø±ê
    for j = 1:3
        if s(i,2)- yrange(j) <= 0.0821
            line = 4 - j;
            break
        end
    end
    if line==-1 || col == -1
        continue
    end
    area_s(line,col) = area_s(line,col) + s(i,3);
end

c = area_d./area_s;
end

