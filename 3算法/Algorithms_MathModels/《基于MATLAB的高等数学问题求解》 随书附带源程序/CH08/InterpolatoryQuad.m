function I=InterpolatoryQuad(varargin)
%INTERPOLATORYQUAD   插值型方法求解定积分
% I=INTERPOLATORYQUAD(X,Y)  计算离散数据积分
% I=INTERPOLATORYQUAD(FUN,A,B,N)  计算函数FUN在积分限[A,B]上的积分，并指定区间等分数为N
%
% 输入参数：
%     ---X,Y：观测数据，等长的向量
%     ---FUN：被积函数
%     ---A,B：积分下限和上限
%     ---N：区间等分数
% 输出参数：
%     ---I：插值型求积结果
%
% See also polyfit, polyint, polyval

args=varargin;
if isnumeric(args{1})
    x=args{1};
    y=args{2};
    N=length(x)-1;
else
    [fun,a,b,N]=deal(args{:});
    h=(b-a)/N;
    x=a+h*(0:N);
    y=feval(fun,x);
end
p=polyfit(x,y,N);
P=polyint(p);
I=polyval(P,x(end))-polyval(P,x(1));
web -broswer http://www.ilovematlab.cn/forum-221-1.html