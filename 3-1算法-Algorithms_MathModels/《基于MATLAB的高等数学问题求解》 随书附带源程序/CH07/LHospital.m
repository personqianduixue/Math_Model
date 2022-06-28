function varargout=LHospital(num,den,x,a)
%LHOSPITAL   洛必达法则求极限
% L=LHOSPITAL(NUM,DEN)或L=LHOSPITAL(NUM,DEN,[])  洛必达法则计算NUM/DEN在0处的极限
% L=LHOSPITAL(NUM,DEN,X)  洛必达法则计算NUM/DEN关于X=0处的极限
% L=LHOSPITAL(NUM,DEN,X,A)  洛必达法则计算NUM/DEN关于X=A处的极限
% [L,FORM]=LHOSPITAL(...)  洛必达法则计算NUM/DEN的极限并返回极限值L和未定式类型FORM
% [L,FORM,K]=LHOSPITAL(...)  洛必达法则计算NUM/DEN的极限并返回极限值L、
%                                 未定式类型FORM和洛必达法则使用次数K
%
% 输入参数：
%     ---NUM,DEN：极限式的分子和分母表达式
%     ---X：符号自变量
%     ---A：极限点
% 输出参数：
%     ---L：极限值
%     ---FORM：未定式类型，包括'∞/∞'和'0/0'
%     ---K：洛必达法则使用次数
%
% See also diff, subs

if nargin<4
    a=0;
end
if nargin<3 || isempty(x)
    x=unique([symvar(num),symvar(den)]);
    if length(x)>1
        error('The Symbolic variable not point out.')
    end
end
fa=subs(num,x,a);
Fa=subs(den,x,a);
if isinf(fa) && isinf(Fa)
    form='∞/∞';
elseif fa==0 && Fa==0
    form='0/0';
else
    error('未定式型式不正确.')
end
k=1;
while 1
    num=diff(num);
    den=diff(den);
    fa=subs(num,x,a);
    Fa=subs(den,x,a);
    switch form
        case '∞/∞'
            if isinf(Fa) && ~isinf(fa)
                L=0;
                break
            end
            if ~isinf(Fa)
                L=subs(num/den,x,sym(a));
                break
            end
        case '0/0'
            if Fa==0 && fa~=0
                L=inf;
                break
            end
            if Fa~=0
                L=subs(num/den,x,sym(a));
                break
            end
    end
    k=k+1;
end
if nargout==1
    varargout{1}=L;
elseif nargout==2
    varargout{1}=L;
    varargout{2}=form;
elseif nargout==3
    varargout{1}=L;
    varargout{2}=form;
    varargout{3}=k;
else
    error('Wrong number of output arguments.')
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html