% chapter2_3_1.m  第2.3.1节 标识符与数组
%%
a=1:5				% 行向量

b=[0,1,2;3,4,5]		% 2*3矩阵

c=b(:,2)			% 取b的第2列

s=input('请输入一行字符串：','s');

s					% 用input函数输入字符串


%%
pi=4		% 将pi赋值为4，覆盖圆周率的值
2*pi^2		% 用新的值参与计算
clear pi	% 清除变量pi
pi			% pi的值恢复为圆周率的值

%%
rand('seed',2)
a=rand(2,2)			% 2*2矩阵
a(2,1)				% 全下标方式
a(2)				% 单下标方式
b=a>0.8
a(b)				% 逻辑1方式

%%
rand('seed',2)
a=rand(3,4)			% 3*4矩阵
a(2,:)				% 矩阵的第2行
a(2,2:end)			% 矩阵的第2行中从第2个元素到最后一个元素
a(3,:)=[]			% 删除矩阵的第三行

web -broswer http://www.ilovematlab.cn/forum-222-1.html