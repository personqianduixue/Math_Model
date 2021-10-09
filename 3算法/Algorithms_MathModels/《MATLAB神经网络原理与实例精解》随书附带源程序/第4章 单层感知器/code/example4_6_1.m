% example4_6_1.m 
%% 清理
clear,clc
close all

%% adapt用于感知器

% 创建感知器
net=newp([-1,2;-2,2],1);

% 定义训练向量
P={[0;0] [0;1] [1;0] [1;1]};
T={0,0,1,1};

% 进行调整
[net,y,ee,pf] = adapt(net,P,T);
ma=mae(ee)
ite=0;
while ma>=0.15
  [net,y,ee,pf] = adapt(net,P,T,pf);  
  ma=mae(ee)
  newT=sim(net,P)
  ite=ite+1;
  if ite>=10
      break;
  end
end
web -broswer http://www.ilovematlab.cn/forum-222-1.html