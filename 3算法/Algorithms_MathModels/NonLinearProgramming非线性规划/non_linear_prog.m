%% 求解非线性规划案例
rng('shuffle');
options = optimset('largescale', 'off');
[x, y] = fmincon('fun1', rand(3, 1), [], [], [], [], zeros(3, 1), [], ...
'fun2', options)

%使用optimtool调出工具箱也可以直接求解