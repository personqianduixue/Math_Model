function [flag,index] = ismature(pop)

[~,index] = max(pop(:,end));
if index == 1
    flag = 1;
else
    flag = 0;
end