% 每平方的性价比
clear,clc
%% 读入数据
data=xlsread('cumcm2012B_附件3_三种类型的光伏电池(A单晶硅B多晶硅C非晶硅薄膜)组件设计参数和市场价格.xls');
pice=[14.9 12.5 4.8];
long=data(:,2);%长
wide=data(:,3);%宽
U=data(:,4);%电压
I=data(:,5);%电流
eta=data(:,6);%转换率
P=U.*I;
S=long.*wide/1000;
%% 每平米价格
for i=1:6
    p1(i)=P(i)*pice(1)/S(i);
  
end %A单晶硅
for i=7:13
          p1(i)=P(i)*pice(2)/S(i);
end  %B多晶硅
for i=14:24
  p1(i)=P(i)*pice(3)/S(i);
end  %C非晶硅薄膜
%% 每平方的性价比
ratio=eta./p1';
plot(1:6,ratio(1:6),'k-*')
hold on
plot(7:13,ratio(7:13),'k-s')
hold on
plot(14:24,ratio(14:24),'k-d')
text()

set(gca,'xtick',[0:1:24])