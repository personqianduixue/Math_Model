clc, clear
x=[129,140,103.5,88,185.5,195,105,157.5,107.5,77,81,162,162,117.5];
y=[7.5,141.5,23,147,22.5,137.5,85.5,-6.5,-81,3,56.5,-66.5,84,-33.5];
z=-[4,8,6,8,6,8,8,9,9,8,8,9,4,9];
xmm=minmax(x)  %求x的最小值和最大值
ymm=minmax(y)  %求y的最小值和最大值
xi=xmm(1):xmm(2);
yi=ymm(1):ymm(2);
zi1=griddata(x,y,z,xi,yi','cubic'); %立方插值
zi2=griddata(x,y,z,xi,yi','nearest'); %最近点插值
zi=zi1;  %立方插值和最近点插值的混合插值的初始值
zi(isnan(zi1))=zi2(isnan(zi1))  %把立方插值中的不确定值换成最近点插值的结果
subplot(1,2,1), plot(x,y,'*')
subplot(1,2,2), mesh(xi,yi,zi)
