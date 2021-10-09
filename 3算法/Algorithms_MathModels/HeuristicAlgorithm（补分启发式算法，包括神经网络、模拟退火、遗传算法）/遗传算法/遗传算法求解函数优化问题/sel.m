%“选择”操作
function seln=sel(s,p);

inn=size(p,1);

%从种群中选择两个个体
for i=1:2
   r=rand;  %产生一个随机数
   prand=p-r;
   j=1;
   while prand(j)<0
       j=j+1;
   end
   seln(i)=j; %选中个体的序号
end