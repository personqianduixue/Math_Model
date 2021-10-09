function [xmax,fmax,xmin,fmin]=Extremum2(fun)
%EXTREMUM2   求二元函数的极值与极值点
% [XMAX,FMAX,XMIN,FMIN]=EXTREMUM2(FUN)  求二元函数FUN的极值与极值点
%
% 输入参数：
%     ---FUN：二元函数符号表达式
% 输出参数：
%     ---XMAX,XMIN：极大值和极小值点
%     ---FMAX,FMIN：极大值和极小值
%
% See also diff

if ~isa(fun,'sym')
    error('FUN must be a Symbolic function.')
end
dfx=diff(fun,'x');
dfy=diff(fun,'y');
[x0,y0]=solve(dfx,dfy,'x','y');
xmax=[];xmin=[];
for k=1:length(x0)
    A=subs(diff(dfx,'x'),{'x','y'},{x0(k),y0(k)});
    B=subs(diff(dfx,'y'),{'x','y'},{x0(k),y0(k)});
    C=subs(diff(dfy,'y'),{'x','y'},{x0(k),y0(k)});
    if double(A*C-B^2)>0
        if double(A)<0
            xmax=[xmax;[x0(k),y0(k)]];
        else
            xmin=[xmin;[x0(k),y0(k)]];
        end
    end
end
if ~isempty(xmax)
    fmax=subs(fun,{'x','y'},{xmax(:,1),xmax(:,2)});
else
    fmax=[];
end
if ~isempty(xmin)
    fmin=subs(fun,{'x','y'},{xmin(:,1),xmin(:,2)});
else
    fmin=[];
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html