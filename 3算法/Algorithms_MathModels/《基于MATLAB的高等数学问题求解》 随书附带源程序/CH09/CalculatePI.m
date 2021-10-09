function PI=CalculatePI(n)
%CALCULATEPI   圆周率PI的级数算法
% PI=CALCULATEPI(N)  利用幂级数计算圆周率的值
%
% 输入参数：
%     ---N：级数所取的项数
% 输出参数：
%     ---PI：圆周率的近似值
%
% See also pi

if nargin==0
    n=1000;
end
PI=0;
for k=1:n
    a=(-1)^(k-1)/(2*k-1);
    PI=PI+a;
end
PI=4*PI;
web -broswer http://www.ilovematlab.cn/forum-221-1.html