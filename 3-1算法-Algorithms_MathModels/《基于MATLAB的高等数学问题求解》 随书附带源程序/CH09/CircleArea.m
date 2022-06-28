function A=CircleArea(R,n)
%CIRCLEAREA   圆面积的无限逼近计算
% A=CIRCLEAREA(R,N)  利用多边形面积无限逼近圆的面积
%
% 输入参数：
%     ---R：圆的半径
%     ---N：正多边形边数
% 输出参数：
%     ---A：圆的近似面积
%
% See also symsum

M=R;
A=sqrt(3)/4*M^2*6;
for k=2:n
    G=sqrt(R^2-(M/2)^2);
    j=R-G;
    m=sqrt((M/2)^2+j^2);
    a=1/2*M*j*3*2^(k-1);
    M=m;
    A=A+a;
end
if isa(R,'sym')
    A=simple(A);
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html