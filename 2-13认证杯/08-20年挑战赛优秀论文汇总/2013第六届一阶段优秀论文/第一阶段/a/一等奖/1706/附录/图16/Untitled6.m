x=[7.5,10.0,20.0,30.0,40.0]
y=[1.05,1.0,0.61,0.34,0.23]
xi=1:1:41
y1 = interp1(x,y,xi,'spline')
plot(x,y,'bo')
hold on
plot(xi,y1,'r*-')
title('减速率与框架间隔长度关系三次样条插值曲线')
xlabel('DL/m')
ylabel('\eta/\eta_{10}')
xlim([0,60])
ylim([0,1.2])