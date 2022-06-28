% 计算队列长度

function [cal] = calline(road)
global length DU;
cals = zeros(1,3);
for i = 2:4
   for j = 2:length-1
       if road(i,j) == DU && road(i,j+1) == DU
          cals(i-1) = cals(i-1)+1;                                         
       end
   end
end    
    
cal = max(cals);
end