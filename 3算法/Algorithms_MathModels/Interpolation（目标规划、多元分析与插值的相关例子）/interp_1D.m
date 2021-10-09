%% 一维插值方法的调用
% yi=interp1(x，y，xi，'method')
% x，y为插值节点向量，xi为被插值点
% method代表插值方法
%‘nearest’  最邻近插值
% ‘linear’  线性插值；
% ‘spline’  三次样条插值；
% ‘cubic’   立方插值；
% 缺省时     分段线性插值

hours=1:12;
temps=[5 8 9 15 25 29 31 30 22 25 27 24];
h=1:0.1:12;
t=interp1(hours,temps,h,'spline');  
plot(hours,temps,'+',h,t,hours,temps,'r:')    
xlabel('Hour'),ylabel('Degrees Celsius')
