function I=ArcCurveInt(fun,vars,varargin)
%ARCCURVEINT   计算第一类曲线积分
% I=ARCCURVEINT(FUN,{'X','Y'},FUNX,FUNY,T,ALPHA,BETA)  计算二元函数的第一类曲线积分
% I=ARCCURVEINT(FUN,{'X','Y','Z'},FUNX,FUNY,FUNZ,T,ALPHA,BETA)  计算三元函数的
%                                                               第一类曲线积分
% I=ARCCURVEINT(FUN,{'X','Y','Z',...},FUNX,FUNY,FUNZ,...,T,ALPHA,BETA)
%                                                计算多元函数的第一类曲线积分
%
% 输入参数：
%     ---FUN：被积函数
%     ---VARS：被积函数的符号变量
%     ---FUNX,FUNY,...：积分曲线的参数方程
%     ---T：参数方程的符号自变量
%     ---ALPHA,BETA：积分范围
% 输出参数：
%     ---I：曲线积分值
%
% See also diff, int

args=varargin;
[t,alpha,beta]=deal(args{end-2:end});
S=0;
for k=1:nargin-5
    fun=subs(fun,vars{k},args{k});
    df=diff(args{k},t);
    S=S+df^2;
end
I=int(fun*sqrt(S),t,alpha,beta);
web -broswer http://www.ilovematlab.cn/forum-221-1.html