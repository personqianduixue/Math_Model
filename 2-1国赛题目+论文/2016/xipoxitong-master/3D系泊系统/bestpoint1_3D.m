function [bestz0, besty0, bestx0] = bestpoint1_3D(H, y0, x0, v1, v2, m_qiu, I, L, beta, xitong_figure)
%此函数用fzero法求最优吃水深度h
% 
%%%%输入%%%%
% H：海水深度
% y0：浮标初始纵坐标
% x0：浮标初始横坐标
% v1：风速
% v2：风速
% m_qiu：重物球质量
% I ：锚链型号
% L：锚链长度
% xitong_figure：是否输出系统图像
%
%%%%输出%%%%
% bestz0：浮标最优z坐标
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

fun = @(z0)bestpoint3_3Dfun(z0, H, y0, x0, v1, v2, m_qiu, I, L, beta, xitong_figure);
z0 = -0.3; % initial point
bestz0 = fzero(fun, z0);
[~, y, x, ~, ~, ~, ~] = For3D(bestz0, y0, x0, v1, v2, m_qiu, I, L, beta, xitong_figure);
besty0 = y0 - y(end);
bestx0 = x0 - x(end);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = bestpoint3_3Dfun(z0, H, y0, x0, v1, v2, m_qiu, I, L, beta, xitong_figure)
%此函数用于构建fzero函数的输入，以求解zn = -H。
%

[z, ~, ~, ~, ~, ~, ~] = For3D(z0, y0, x0, v1, v2, m_qiu, I, L, beta, xitong_figure);
zn = z(end);
f = zn - (-H);
end