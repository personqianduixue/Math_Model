function varargout=Laplace_Define(varargin)
%LAPLACE_DEFINE   根据定义求函数的拉氏变换
% FS=LAPLACE_DEFINE(FT,T,S,'laplace')  求函数FT的laplace变换
% FT=LAPLACE_DEFINE(FS,S,T,'ilaplace')  求函数FS的laplace逆变换
%
% 输入参数：
%     ---FT,FS：给定的时域函数和复域函数
%     ---T,S：函数FT和FS的自变量
%     ---TYPE：指定laplace变换的类型，有'laplace'和'ilaplace'两种取值
% 输出参数：
%     ---FS,FT：求得的复域函数和时域函数
%
% See also int

args=varargin;
type=args{end};
switch lower(type)
    case {1,'laplace'}
        [fun,t,s]=args{1:end-1};
        L=int(fun*exp(-s*t),t);
        L=-subs(L,t,0);
    case {2,'ilaplace'}
        [fun,s,t]=args{1:end-1};
        [~,B]=numden(fun);
        S=sort(solve(B,s));
        H=FrequencyTable(S);
        S=H(:,1); P=H(:,2);
        L=0;
        for i=1:length(S)
            F=(s-S(i))^P(i)*fun*exp(s*t);
            M=diff(F,s,double(P(i)-1));
            L=L+1/gamma(P(i))*limit(M,s,S(i));
        end
end
varargout{1}=L;
web -broswer http://www.ilovematlab.cn/forum-221-1.html