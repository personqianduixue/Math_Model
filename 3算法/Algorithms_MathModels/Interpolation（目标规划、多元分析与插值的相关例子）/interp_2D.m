%% 二维插值方法的调用
% z=interp2(x0,y0,z0,x,y,’method’)

x=1:5;
y=1:3;
temps=[82 81 80 82 84; 79 63 61 65 81; 84 84 82 85 86];
mesh(x,y,temps)
pause

xi=1:0.2:5;
yi=1:0.2:3;
zi=interp2(x,y,temps,xi',yi,'cubic');
figure(2)
mesh(xi,yi,zi)
