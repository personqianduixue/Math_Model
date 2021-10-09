clear
Lh=83;
h=70;
yuliu=3;
for zcwz=30:5:50
y=-37.5:2.5:-2.5;
x=-sqrt(40^2-y.^2);
x=[-yuliu,x];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
l=x-(-Lh);
k=Lh-yuliu-zcwz;
yo=-k*h/(Lh-yuliu);
xo=-sqrt(k^2-yo^2)+x(1);
d=sqrt((xo-x).^2+yo^2);
xx=(xo-x).*(l-d)./d+xo;
yy=yo.*(l-d)./d+yo;
xx2=xx(length(xx):-1:1);
yy2=yy(length(yy):-1:1);
xx1=[xx,xx2];
yy1=[yy,yy2];
zz=-38.75:2.5:38.75;
xo1=xo*ones(size(zz));
yo1=yo*ones(size(zz));
plot3(xo1,zz,yo1,'r');
hold on;
plot3(xx1,zz,yy1);
hold on
end