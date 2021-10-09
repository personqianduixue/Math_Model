function [besty0, bestx0] = bestpoint3(H, x0, v_wind, m_qiu, I, L, xitong_figure)
%此函数用fzero法求最优吃水深度h
% 
%%%%输入%%%%
% H：海水深度
% x0：浮标初始横坐标
% v_wind：风速
% m_qiu：重物球质量
% I ：锚链型号
% L：锚链长度
% y0_yn_figure：是否输出y0与yn的函数图像
%
%%%%输出%%%%
% besty0：浮标最优纵坐标
% bestx0：浮标最优横坐标
%
%%%%此程序用于求解下面问题%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 某型传输节点选用II型电焊锚链22.05m，
% 选用的重物球的质量为1200kg。
% 现将该型传输节点布放在水深18m、
% 海床平坦、海水密度为1.025×103kg/m3的海域。
% 若海水静止，分别计算海面风速为12m/s和24m/s时钢桶和
% 各节钢管的倾斜角度、锚链形状、浮标的吃水深度和游动区域
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

fun = @(y0)bestpoint3fun(y0, H, x0, v_wind, m_qiu, I, L, xitong_figure);
y0 = -0.3; % initial point
besty0 = fzero(fun, y0);
[~, x, ~, ~, ~] = For2D(besty0, x0, v_wind, m_qiu, I, L, xitong_figure);
bestx0 = x0 - x(end);
end

function f = bestpoint3fun(y0, H, x0, v_wind, m_qiu, I, L, xitong_figure)
%此函数用于构建fzero函数的输入，以求解yn = -H。
%

[y, ~, ~, ~, ~] = For2D(y0, x0, v_wind, m_qiu, I, L, xitong_figure);
yn = y(end);
f = yn - (-H);
end










