%% 风速v1对系统状态的影响
clc
clear
% 敏感性参数v1
v1 = 6:6:36;
%其他参数
H = 18;
v2 = 1.5;
m_qiu = 1200;
I = 2;
L = 22.05;
xitong_figure = 0;%求最优点时 = 0，绘制系统时 = 1；

%%%%正文%%%%
figure(1)
for i = 1:length(v1)
    A{i} = ['风速', num2str(v1(i))];
    xitong_save = 0;
    bestxx = bestpoint3_expand(H, v1(i), v2, m_qiu, I, L, xitong_figure, xitong_save);%求最优点

    xitong_save = 1;
    [~]= For2D_expand(bestxx, H, v1(i), v2, m_qiu, I, L, xitong_figure, xitong_save);%绘制系统
    load('系统信息.mat', 'stat')
    x(:, i) = stat.x;
    y(:, i) = stat.y;
    plot(x(:, i), y(:, i), '-', 'color', rand(3, 1))
    hold on
end
hold off
legend(A, 'location', 'best')
xlabel('风向')
ylabel('系统状态')
title('风速v1对系泊系统的影响')

%% 水速v2对系统状态的影响
clc
clear
% 敏感性参数v1
v2 = -1.5:0.5:1.5;
%其他参数
H = 18;
v1 = 36;
m_qiu = 1200;
I = 2;
L = 22.05;
xitong_figure = 0;
%%%%正文%%%%
figure(2)
for i = 1:length(v2)
    A{i} = ['水速', num2str(v2(i))];
    xitong_save = 0;%求最优点时 = 0，保存系统时 = 1；
    bestxx = bestpoint3_expand(H, v1, v2(i), m_qiu, I, L, xitong_figure, xitong_save);%求最优点

    xitong_save = 1;
    [~]= For2D_expand(bestxx, H, v1, v2(i), m_qiu, I, L, xitong_figure, xitong_save);%绘制系统
    load('系统信息.mat', 'stat')
    x(:, i) = stat.x;
    y(:, i) = stat.y;
    plot(x(:, i), y(:, i), '-', 'color', rand(3, 1))
    hold on
end
hold off
legend(A, 'location', 'best')
xlabel('风向')
ylabel('系统状态')
title('水速v2对系泊系统的影响')

%% 海水深度H对系统状态的影响
clc
clear
% 敏感性参数v1
H = 16:20;
%其他参数
v1 = 36;
v2 = 1.5;
m_qiu = 1200;
I = 2;
L = 22.05;
xitong_figure = 0;

%%%%正文%%%%
figure(3)
for i = 1:length(H)
    A{i} = ['水深', num2str(H(i))];
    xitong_save = 0;%求最优点时 = 0，绘制系统时 = 1；
    bestxx = bestpoint3_expand(H(i), v1, v2, m_qiu, I, L, xitong_figure, xitong_save);%求最优点

    xitong_save = 1;
    [~]= For2D_expand(bestxx, H(i), v1, v2, m_qiu, I, L, xitong_figure, xitong_save);%绘制系统
    load('系统信息.mat', 'stat')
    x(:, i) = stat.x;
    y(:, i) = stat.y;
    plot(x(:, i), y(:, i), '-', 'color', rand(3, 1))
    hold on
end
hold off
legend(A, 'location', 'best')
xlabel('风向')
ylabel('系统状态')
title('水深H对系泊系统的影响')




































