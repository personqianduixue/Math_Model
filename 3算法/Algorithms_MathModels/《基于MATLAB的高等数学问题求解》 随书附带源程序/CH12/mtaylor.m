function T=mtaylor(fun,x0,n)
%MTAYLOR   二元函数的泰勒展开式
% T=MTAYLOR(FUN)  求二元函数FUN在原点处的6阶泰勒展开式
% T=MTAYLOR(FUN,X0)  求二元函数FUN在点X0处的6阶泰勒展开式
% T=MTAYLOR(FUN,X0,N)  求二元函数FUN在点X0处的N阶泰勒展开式
%
% 输入参数：
%     ---FUN：给定的二元函数
%     ---X0：泰勒展开点，以元胞数组数组给出，形如{'x=0','y=0'}
%     ---N：泰勒展开阶次
% 输出参数：
%     ---T：返回的泰勒展开式
%
% See also taylor, diff

if nargin<3
    n=6;
end
if nargin<2 || isempty(x0)
    x0={'x=0','y=0'};
end
vars=cell(1,2); values=cell(1,2);
for k=1:2
    kk=strfind(x0{k},'=');
    vars{k}=x0{k}(1:kk-1);
    values{k}=sym(x0{k}(kk+1:end));
end
T=subs(fun,vars,values);
for m=1:n
    S=0;
    for p=0:m
        sigma=nchoosek(m,p)*(sym(vars{1})-values{1})^p*...
            (sym(vars{2})-values{2})^(m-p)*...
            subs(diff(diff(fun,vars{1},p),vars{2},m-p),vars,values);
        S=S+sigma;
    end
    T=T+S/gamma(m+1);
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html