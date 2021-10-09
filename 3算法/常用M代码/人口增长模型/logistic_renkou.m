function logistic_renkou
clc;
clear all
 xdata = [1790 1800 1810 1820 1830 1840 1850 1860 1870 1880 ...
    1890 1900 1910 1920 1930 1940 1950 1960 1970 1980 1990 2000];
ydata = [3.9 5.3 7.2 9.6 12.9 17.1 23.2 31.4 38.6 50.2 62.9 76.0 ...
    92.0 106.5 123.2 131.7 150.7 179.3 204.0 226.5 251.4 281.4];

a0 = [400 0.25];   % ³õÊ¼²Â²âÖµ
[a, resnorm] = lsqcurvefit(@logistic,a0,xdata,ydata)
 
yfit = a(1)./(1+(a(1)/3.9-1)*exp(-a(2)*(xdata-1790)));
plot(xdata,ydata,'*b',xdata,yfit,'-r')
 
function y = logistic(a,xdata)
y = a(1)./(1+(a(1)/3.9-1)*exp(-a(2)*(xdata-1790)));
