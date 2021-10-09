clear
for h=linspace(0,50,8)
yuliu=3;
y=-22.5:2.5:-2.5;
x=-sqrt(25^2-y.^2);
x=[-yuliu,x];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
l=x-(-60);
xo=-sqrt((l(1)/2)^2-(h/2)^2)+x(1);
yo=-0.5*h;
d=sqrt((xo-x).^2+yo^2);
xx=(xo-x).*(l-d)./d+xo;
yy=yo.*(l-d)./d+yo;
xx2=xx(length(xx):-1:1);
yy2=yy(length(yy):-1:1);
xx1=[xx,xx2];
yy1=[yy,yy2];
zz=-23.75:2.5:23.75;
xo1=xo*ones(size(zz));
yo1=yo*ones(size(zz));
plot3(xo1,zz,yo1,'r');
hold on;
plot3(xx1,zz,yy1);
hold on

end
grid on 