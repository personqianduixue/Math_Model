% floyd算法的函数文件
function [d,path]=floyd(a) 
% floyd   - 最短路问题  
%    a    - 距离矩阵是指i到j之间的距离可以是有向的   
%    d    - 最短路的距离  
%    path - 最短路的路径  
[n,lie]=size(a);   %  n为a的行数
d=a; 
path=zeros(n,n); 
for i=1:n 
   for j=1:n
       if d(i,j)~=inf 
           path(i,j)=j; %j是i的后续点 
       end 
   end 
end  
for k=1:n
    for i=1:n 
      for j=1:n 
         if d(i,j)>d(i,k)+d(k,j) 
            d(i,j)=d(i,k)+d(k,j); 
            path(i,j)=path(i,k); 
         end 
      end 
   end 
end 
