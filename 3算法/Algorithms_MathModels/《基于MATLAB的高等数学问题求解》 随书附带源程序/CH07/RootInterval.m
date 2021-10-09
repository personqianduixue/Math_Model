function r=RootInterval(fun,a,b,h)
%ROOTINTERVAL   逐步扫描法求方程的隔根区间
% R=ROOTINTERVAL(FUN,A,B)
% R=ROOTINTERVAL(FUN,A,B,H)
%
% 输入参数：
%     ---FUN：方程的MATLAB描述，可以为匿名函数或内联函数
%     ---A,B：区间端点
%     ---H：步长
% 输出参数：
%     ---R：返回的隔根区间，是一个列数为2的矩阵

if nargin==3
    h=(b-a)/100;
end
a1=a;b1=a1+h;
r=[];
while b1<b
    if fun(a1)*fun(b1)<0
        r=[r;[a1,b1]];
        a1=b1;b1=a1+h;
    else
        a1=b1;b1=a1+h;
        continue
    end
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html