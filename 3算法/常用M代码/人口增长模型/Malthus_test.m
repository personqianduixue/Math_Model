% Malthus模型  1790-1900年
function Malthus_test
clc 
clear all
xdata = [1790 1800 1810 1820 1830 1840 1850 1860 1870 1880 1890 1900];
ydata = [3.9 5.3 7.2 9.6 12.9 17.1 23.2 31.4 38.6 50.2 62.9 76.0];
r0 = 0.25;   % 初始猜测值
[r, resnorm] = lsqcurvefit(@malthus,r0,xdata,ydata)
 
yfit = 3.9*exp(r*(xdata-1790));
plot(xdata,ydata,'*b',xdata,yfit,'-r')
 


