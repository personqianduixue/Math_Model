clc, clear
sj0=load('sj.txt');    %加载100个目标的数据，数据按照表格中的位置保存在纯文本文件sj.txt中
x=sj0(:,[1:2:8]);x=x(:);
y=sj0(:,[2:2:8]);y=y(:);
sj=[x y]; d1=[70,40]; 
sj=[d1;sj;d1]; sj=sj*pi/180; %角度化成弧度
d=zeros(102); %距离矩阵d初始化
for i=1:101
   for j=i+1:102
d(i,j)=6370*acos(cos(sj(i,1)-sj(j,1))*cos(sj(i,2))*cos(sj(j,2))+sin(sj(i,2))*sin(sj(j,2)));
   end
end
d=d+d';
path=[];long=inf; %巡航路径及长度初始化
rand('state',sum(clock));  %初始化随机数发生器
for j=1:1000  %求较好的初始解
    path0=[1 1+randperm(100),102]; temp=0;
    for i=1:101
        temp=temp+d(path0(i),path0(i+1));
    end
    if temp<long
        path=path0; long=temp;
    end
end
e=0.1^30;L=20000;at=0.999;T=1;
for k=1:L  %退火过程
c=2+floor(100*rand(1,2));  %产生新解
c=sort(c); c1=c(1);c2=c(2);
  %计算代价函数值的增量
df=d(path(c1-1),path(c2))+d(path(c1),path(c2+1))-d(path(c1-1),path(c1))-d(path(c2),path(c2+1));
  if df<0 %接受准则
  path=[path(1:c1-1),path(c2:-1:c1),path(c2+1:102)]; long=long+df;
  elseif exp(-df/T)>rand
  path=[path(1:c1-1),path(c2:-1:c1),path(c2+1:102)]; long=long+df;
  end
  T=T*at;
   if T<e
       break;
   end
end
path, long % 输出巡航路径及路径长度
xx=sj(path,1);yy=sj(path,2);
plot(xx,yy,'-*') %画出巡航路径
