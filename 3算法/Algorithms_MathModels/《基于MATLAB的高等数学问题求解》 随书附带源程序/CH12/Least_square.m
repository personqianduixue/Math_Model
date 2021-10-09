function [p,A,b,FitFun]=Least_square(x,y,phifun,wfun)
%LEAST_SQUARE   最小二乘法
% P=LEAST_SQUARE(X,Y,PHIFUN)  利用基函数PHIFUN来拟合数据X和Y
% P=LEAST_SQUARE(X,Y,PHIFUN,WFUN)  利用基函数PHIFUN和权函数WFUN拟合数据X和Y
% [P,A,B]=LEAST_SQUARE(...)  最小二乘法拟合数据并返回法方程组的系数矩阵和右端向量
% [P,A,B,FITFUN]=LEAST_SQUARE(...)  最小二乘法拟合数据并返回拟合函数表达式
%
% 输入参数：
%     ---X,Y：实验数据
%     ---PHIFUN：拟合基函数，可以是匿名函数或内联函数
%     ---WFUN：权函数
% 输出参数：
%     ---P：最小二乘拟合系数
%     ---A：法方程组的系数矩阵
%     ---B：法方程组的右端向量
%     ---FITFUN：拟合函数表达式
%
% See also polyfit, lsqcurvefit

x=x(:); y=y(:);
if length(x)~=length(y)
    error('实验数据长度不一致.')
end
if nargin<4
    wfun=ones(size(x));
end
func=char(phifun);
func=strrep(func,'ones(size(x))','1');
func=strrep(func,'.*','*');
func=strrep(func,'./','/');
func=strrep(func,'.^','^');
k=strfind(func,'[');
func=sym(func(k(1):end));
phifun=phifun(x);
n=size(phifun,2);
A=zeros(n);b=zeros(n,1);
for k=1:n
    for j=1:n
        A(k,j)=0;
        for i=1:length(x)
            A(k,j)=A(k,j)+wfun(i)*phifun(i,j)*phifun(i,k);
        end
    end
    for i=1:length(x)
        b(k)=b(k)+wfun(i)*y(i)*phifun(i,k);
    end
end
p=A\b;
FitFun=vpa(dot(p,func),4);
web -broswer http://www.ilovematlab.cn/forum-221-1.html