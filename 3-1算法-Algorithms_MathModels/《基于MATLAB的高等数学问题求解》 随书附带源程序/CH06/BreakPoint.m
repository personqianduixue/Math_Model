function [tf,str]=BreakPoint(x0,fun_left,fun_x0,fun_right)
%BREAKPOINT   判断函数在某点处的间断点类型
% [TF,STR]=BREAKPOINT(X0,FUN_LEFT,FUN_X0,FUN_RIGHT)  判断函数FUN在X0处的间断性，
%                                                              并返回间断点类型
%
% 输入参数：
%     ---X0：指定的点
%     ---FUN_LEFT：X<X0时的函数表达式
%     ---FUN_X0：X=X0时的函数表达式
%     ---FUN_RIGHT：X>X0时的函数表达式
% 输出参数：
%     ---TF：函数的连续性，若函数在X0处连续，则TF=1；否则TF=0
%     ---STR：间断点类型字符串，STR可以为'无穷间断点'、'可去间断点'、'振荡间断点'、
%              '跳跃间断点'和'函数在该点连续.'五种情形之一
%
% See also FunContinuity, limit

fx0_left=limit(fun_left,'x',x0,'left');
fx0_right=limit(fun_right,'x',x0,'right');
tf=1;
if isempty(fun_x0)
    tf=0;
else
    if isnan(fx0_left) || isnan(fx0_right) ||...  % 极限不存在
            isinf(double(fx0_left)) || isinf(double(fx0_right))
        tf=0;
    else   % 极限存在
        fx0=subs(fun_x0,'x',x0);
        if ~isequal(fx0,fx0_left) || ~isequal(fx0,fx0_right)
            tf=0;
        end
    end
end
if tf==0
    if isinf(double(fx0_left)) || isinf(double(fx0_right))  % 左或右极限是否为无穷大
        str='无穷间断点';
    elseif isequal(fx0_left,fx0_right)  % 判断左右极限是否相等
        str='可去间断点';
    elseif isnan(fx0_left) || isnan(fx0_right)  % 判断左极限或右极限是否存在
        str='振荡间断点';
    else
        str='跳跃间断点';
    end
else
    str='函数在该点连续.';
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html