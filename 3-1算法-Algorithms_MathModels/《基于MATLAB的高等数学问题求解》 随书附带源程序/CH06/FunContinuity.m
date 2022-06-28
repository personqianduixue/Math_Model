function tf=FunContinuity(x0,fun_left,fun_x0,fun_right)
%FUNCONTINUITY   判断函数在某点处的连续性
% TF=FUNCONTINUITY(X0,FUN_LEFT,FUN_X0,FUN_RIGHT)  判断分段函数FUN在点X0处的连续性，
%               若连续则返回TF=1；否则返回TF=0，FUN由其左右表达式以及在点X0处的表达式表示
%
% 输入参数：
%     ---X0：指定的点
%     ---FUN_LEFT：X<X0时的函数表达式
%     ---FUN_X0：X=X0时的函数表达式
%     ---FUN_RIGHT：X>X0时的函数表达式
% 输出参数：
%     ---TF：函数的连续性，若函数在X0处连续，则TF=1；否则TF=0
%
% See also limit

fx0=subs(fun_x0,'x',x0);
fx0_left=limit(fun_left,'x',x0,'left');
fx0_right=limit(fun_right,'x',x0,'right');
if isequal(fx0,fx0_left) && isequal(fx0,fx0_right)
    tf=1;
else
    tf=0;
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html