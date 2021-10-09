function [I,str]=ComplexQuad(varargin)
%COMPLEXQUAD   复化求积方法求解定积分
% I=COMPLEXQUAD(X,Y,TYPE)  使用指定的复化求积方法求离散数据的数值积分
% I=COMPLEXQUAD(FUN,A,B,N,TYPE)  使用指定的复化求积方法求函数FUN的数值积分
% [I,STR]=COMPLEXQUAD(...)  使用复化求积方法求数值积分并返回所采用的复化方法
%
% 输入参数：
%     ---X,Y：观测数据，等长向量
%     ---FUN：被积函数
%     ---A,B：积分下限和上限
%     ---N：积分区间等分数
%     ---TYPE：指定的复化方法类型，有以下取值：
%              1.'trape'或1：复化梯形求积
%              2.'simpson'或2：复化辛普森求积
%              3.'cotes'或4：复化Cotes求积
% 输出参数：
%     ---I：返回的数值积分值
%     ---STR：返回的复化方法
%
% See also InterpolatoryQuad

args=varargin;
type=args{end};
num=[1,2,4];
S={'trape','simpson','cotes'};
if ~isnumeric(type)
    I=ismember(S,type);
    n=num(I==1);
else
    n=type;
end
if isnumeric(args{1})
    x=args{1};
    y=args{2};
    N=length(x);
    if rem(N-1,n)~=0
        error('数据的长度与所选的求积方法不匹配.')
    end
    Nn=(N-1)/n;
    h=(x(N)-x(1))/Nn;
else
    [fun,a,b,Nn]=deal(args{1:end-1});
    h=(b-a)/Nn;
    x=a+h/n*(0:n*Nn);
    N=length(x);
    y=feval(fun,x);
end
switch lower(type)
    case {1,'trape'}
        str='复化梯形求积';
        I=h*[1,2*ones(1,Nn-1),1]*y'/2;
    case {2,'simpson'}
        str='复化辛普森求积';
        a=[1,reshape([4*ones(1,Nn-1);2*ones(1,Nn-1)],1,[]),4,1];
        I=h/6*a*y';
    case {4,'cotes'}
        str='复化Cotes求积';
        a=[7,reshape([32*ones(1,Nn-1);12*ones(1,Nn-1);...
            32*ones(1,Nn-1);14*ones(1,Nn-1)],1,N-5),32,12,32,7];
        I=h/90*a*y';
    otherwise
        error('Illegal options.')
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html