function d=poly_str(xd,yd,xi,N)
%POLY_STR   插值型求导算法
% D=POLY_STR(XD,YD,XI,N)  首先数据XD,YD进行多项式插值并求其在点XI处的N阶导数
%
% 输入参数：
%     ---XD,YD：实验数据
%     ---XI：数值求导点
%     ---N：求导阶次
% 输出参数：
%     ---D：N阶数值导数
%
% See also diff, polyfit, polyder, polyval

L=length(xd)-1;
p=polyfit(xd,yd,L);
for k=1:N
    p=polyder(p);
end
d=polyval(p,xi);
web -broswer http://www.ilovematlab.cn/forum-221-1.html