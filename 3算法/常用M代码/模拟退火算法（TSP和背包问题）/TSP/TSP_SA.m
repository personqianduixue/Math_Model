clc,clear 
load berlin52.tsp %加载敌方52个目标的数据，数据按照表格中的位置保存在纯文本文件sj.txt中
berlin52(:,1)=[];
x=berlin52(:,1);
y=berlin52(:,2);
%距离矩阵d 
d=zeros(52); 
for i=1:52
for j=1:52
d(i,j)=sqrt((x(i)-x(j)).^2+(y(i)-y(j)).^2);
end 
end

figure(1)
plot(x,y,'o')
hold on

S0=[];Sum=inf; 
rand('state',sum(clock)); 
for j=1:1000 
S=[1 1+randperm(51),52]; 
temp=0;
for i=1:52
temp=temp+d(S(i),S(i+1)); 
end 
if temp<Sum 
S0=S;Sum=temp; 
end 
end 
e=0.1^30;L=2000;at=0.999;T=1; 
%退火过程
for k=1:L 
    k
%产生新解
c=2+floor(50*rand(2,1)); 
c=sort(c); 
c1=c(1);c2=c(2); 
%计算代价函数值
df=d(S0(c1-1),S0(c2))+d(S0(c1),S0(c2+1))-d(S0(c1-1),S0(c1))-d(S0(c2),S0(c2+1)); 
%接受准则
if df<0 
S0=[S0(1:c1-1),S0(c2:-1:c1),S0(c2+1:53)]; 
Sum=Sum+df; 
elseif exp(-df/T)>rand(1) 
S0=[S0(1:c1-1),S0(c2:-1:c1),S0(c2+1:53)]; 
Sum=Sum+df; 
end 
T=T*at; 
if T<e 
break; 
end 
plot(x(S0),y(S0),'--')
hold on
end 
% 输出巡航路径及路径长度
S0,Sum 
figure(2)
plot(x,y,'*',x(S0),y(S0),'-')

