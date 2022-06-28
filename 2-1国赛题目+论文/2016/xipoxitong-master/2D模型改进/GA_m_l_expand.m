function f = GA_m_l_expand(x, I, c1, c2, v1, v2, H, xitong_figure)
%此函数是第三问求解m_qiu和L优化问题的目标函数，可用于GA和fmincon函数。
%
%解为m_qiu, L, I
%目标：吃水深度最小游动区域和钢桶夹角最小
%

%%%%正文%%%%
m_qiu = x(1);
L = x(2);

xitong_save = 0;
bestxx = bestpoint3_expand(H, v1, v2, m_qiu, I, L, xitong_figure, xitong_save);%求最优点
xitong_save = 1;
[~] = For2D_expand(bestxx, H, v1, v2, m_qiu, I, L, xitong_figure, xitong_save);%绘制系统
load('系统信息.mat', 'stat')
alpha1 = stat.alpha1;
alpha2 = stat.alpha2;
h = stat.h;

%目标值
f = h + c1*alpha1 + c2*pi*bestxx(2)^2;

disp('-----------------------------')
disp(['重物球质量:', num2str(m_qiu)])
disp(['链长:', num2str(L)])
disp(['链型:', num2str(I)])
disp(['目标值f:', num2str(f)])
disp(['吃水深度h:', num2str(h)])
disp(['x0:', num2str(stat.x0)])
disp(['alpha1:', num2str(alpha1)])
disp(['alpha2:', num2str(alpha2)])
disp('-----------------------------')
end









