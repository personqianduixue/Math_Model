function varargout=fouriern(fun,oldvars,newvars,type,method)
%FOURIERN   多重傅里叶变换的求解
% F2=FOURIERN(F1,OLDVARS,NEWVARS)  求函数F1的多重傅里叶变换
% F2=FOURIERN(F1,OLDVARS,NEWVARS,TYPE)  求函数F1的傅里叶变换或逆变换，
%                                       变换类型由TYPE指定
% F2=FOURIERN(F1,OLDVARS,NEWVARS,TYPE,METHOD)  指定采用fourier函数求变换还是
%                                              采用int函数求解
% [F2,S]=FOURIERN(...)  求多重傅里叶变换并返回变换类型
%
% 输入参数：
%     ---F1：初始函数
%     ---OLDVARS：函数F1的变量
%     ---NEWVARS：变换后的变量
%     ---TYPE：指定变换类型，有'fourier'和'ifourier'两种取值
%     ---METHOD：指定求解变换的方法，有'fourier'和'int'两种方法
% 输出参数：
%     ---F2：求变换后的函数
%     ---S：变换类型，对应于TYPE
%
% See also fourier, int

if nargin<5
    method='fourier';
end
if nargin<4 || isempty(type)
    type='fourier';
end
if ~isa(fun,'sym')
    error('FUN must be a Symbolic function.')
end
N=length(oldvars);
if length(newvars)~=N
    error('变量维数不一致.')
end
switch lower(method)
    case 'fourier'
        fcn=lower(type);
        for k=1:N
            fun=feval(fcn,fun,oldvars(k),newvars(k));
        end
    case 'int'
        if isequal(lower(type),'fourier')
            for k=1:N
                fun=int(fun*exp(-1j*oldvars(k)*newvars(k)),oldvars(k),-inf,inf);
            end
        elseif isequal(lower(type),'ifourier')
            for k=1:N
                fun=1/2/pi*int(fun*exp(1j*oldvars(k)*newvars(k)),...
                     oldvars(k),-inf,inf);
            end
        else
            error('Illegal TYPE.')
        end
    otherwise
        error('Illegal METHOD.')
end
if nargout==1
    varargout{1}=fun;
elseif nargout==2
    varargout{1}=fun;varargout{2}=[upper(type),'变换'];
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html