function varargout=ztrans_define(varargin)
%ZTRANS_DEFINE   根据定义求函数的z变换
% EZ=ZTRANS_DEFINE(EN,N,Z,'ztrans')  求序列EN的z变换
% EN=ZTRANS_DEFINE(EZ,Z,N,'iztrans')  求z变换式EZ的z逆变换
%
% 输入参数：
%     ---EN,EZ：给定的序列或z变换式的表达式
%     ---N,Z：EN和EZ的符号自变量
%     ---TYPE：指定z变换类型，可以有'ztrans'和'iztrans'两种取值
% 输出参数：
%     ---EZ,EN：求得的z变换式或z逆变换式
%
% See also Laplace_Define

args=varargin;
type=args{end};
switch lower(type)
    case {1,'ztrans'}
        [en,n,z]=deal(varargin{1:end-1});
        Ez=symsum(en*z^(-n),n,0,inf);
        varargout{1}=Ez;
    case {2,'iztrans'}
        [Ez,z,n]=deal(varargin{1:end-1});
        Ez=Ez*z^(n-1);
        [~,den]=numden(simple(Ez));
        zk=sort(solve(den,z));
        H=FrequencyTable(zk);
        S=H(:,1); P=H(:,2);
        R=0;
        for k=1:length(S)
            D=diff((z-zk(k))^P(k)*Ez,z,double(P(k)-1));
            R=R+1/gamma(P(k))*limit(D,z,zk(k));
        end
        varargout{1}=R;
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html