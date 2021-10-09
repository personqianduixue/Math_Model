function [I,Interval,s]=int_geo(fun,a,b,N)
%INT_GEO  根据定积分的几何意义求定积分
% I=INT_GEO(FUN,A,B)  利用定积分的几何意义计算函数FUN的积分值，积分上下限分别为B和A
% I=INT_GEO(FUN,A,B,N)  利用定积分的几何意义计算定积分，区间等分数为N
% [I,INTERVAL]=INT_GEO(...)  利用定积分的几何意义计算定积分，并返回恒正或恒负区间
% [I,INTERVAL,S]=INT_GEO(...)  利用定积分的几何意义计算定积分，并返回恒正或恒负区间
%                                    以及相应区间上的积分值
%
% 输入参数：
%     ---FUN：函数的MATLAB描述，可以为匿名函数、内联函数或M文件
%     ---A,B：积分下限和上限
%     ---N：各恒正或恒负区间等分数
% 输出参数：
%     ---I：积分值
%     ---INTERVAL：恒正或恒负区间
%     ---S：各区间上的积分值
%
% See also RootInterval, bisect, diff

if nargin<4
    N=1000;
end
r=RootInterval(fun,a,b);
if ~isempty(r)
    n=size(r,1);
    x=ones(1,n+2);
    x(1)=a; x(end)=b;
    for k=1:n
        x(k+1)=bisect(fun,r(k,1),r(k,2));
    end
    x=unique(x);
    L=length(x);
    Interval=zeros(2,L-1);
    for kk=1:L-1
        Interval(:,kk)=x(kk:kk+1);
    end
else
    Interval=[a;b];
end
h=diff(Interval)/N;
M=mean(Interval);
fM=feval(fun,M);
fM(fM>0)=1;
fM(fM<0)=-1;
s=zeros(1,size(Interval,2));
for k=1:size(Interval,2)
    xx=Interval(1,k)+h(k)*(0:N);
    fx=abs(feval(fun,xx));
    s(k)=sum(fx)*h(k);
end
I=sum(s.*fM);
web -broswer http://www.ilovematlab.cn/forum-221-1.html