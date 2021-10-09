function fitness = fun(x)
% 函数功能：计算该个体对应适应度值
% x           input     个体
% fitness     output    个体适应度值

%
load data net inputps outputps

%数据归一化
x=x';
inputn_test=mapminmax('apply',x,inputps);
 
%网络预测输出
an=sim(net,inputn_test);
 
%网络输出反归一化
fitness=mapminmax('reverse',an,outputps);

