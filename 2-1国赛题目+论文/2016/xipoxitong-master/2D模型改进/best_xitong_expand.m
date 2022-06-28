%% 利用bestpoint3_expand计算bestx0, besty0情况下的系统信息及系统图形
clc
clear
%风速为12、24时的系统情况有问题！！！！！！链夹角0时的系统未设置好。
H = 18;
v1 = 36;%风速 m/s
v2 = 0;%水速 m/s
m_qiu = 1200;%重物球质量 kg
I = 2;
L = 22.05;

xitong_figure = 0;%求最优点时 = 0，绘制系统时 = 1；
xitong_save = 0;
bestxx = bestpoint3_expand(H, v1, v2, m_qiu, I, L, xitong_figure, xitong_save);%求最优点

xitong_figure = 1;
[~] = For2D_expand(bestxx, H, v1, v2, m_qiu, I, L, xitong_figure, xitong_save);%绘制系统
