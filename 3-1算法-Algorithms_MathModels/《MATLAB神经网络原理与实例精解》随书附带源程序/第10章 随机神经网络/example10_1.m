% example10_1.m   10.4.1节 simulannealbnd函数

fun=@sa_func		% 函数句柄

% fun =
%
%     @sa_func
rng('default');
rng(0);
x0=rand(1,2)*4;		% 初值
lb=[-4,-4];			% 区间下限
ub=[4,4]			% 区间上限

% ub =
%
%      4     4

% 进行训练
tic;[X,FVAL,EXITFLAG,OUTPUT] = simulannealbnd(fun,x0,lb,ub);toc

X					% 最优值处的自变量值

% X =
%
%    -1.0761    1.0775

FVAL				% 全局最优值

% FVAL =
%
%    -2.2640

EXITFLAG			% 退出标志位

% EXITFLAG =
%
%      1

OUTPUT			% output结构体

% OUTPUT =

%      iterations: 1211
%       funccount: 1224
%         message: 'Optimization terminated: change in best function value less than options.TolFun.'
%        rngstate: [1x1 struct]
%     problemtype: 'boundconstraints'
%     temperature: [2x1 double]
%       totaltime: 0.8594
web -broswer http://www.ilovematlab.cn/forum-222-1.html