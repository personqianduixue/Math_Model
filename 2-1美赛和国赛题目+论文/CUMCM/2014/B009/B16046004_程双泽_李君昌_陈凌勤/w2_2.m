%canshu
global w h a W r x lamda n;
w=2.5;h=70-3;a=1;W=80;lamda=5;r=sqrt(40*40+2.5*2.5);

%youhua qiujie
x=[2.5:2.5:40]';
ts0=[pi/4,h/2];
lb=[0,0];
ub=[pi/2,h];
ts=fmincon(@objfun,ts0,[],[],[],[],lb,ub,@confun)

theta=ts(1);       %youhua jieguo
s=ts(2);                %youhua jieguo
l=w+h/sin(theta);
d=l-s;
n=80/2.5+1;

%zhuobian dian zuobiao
xc=-40:2.5:40;
yc=sqrt(r^2-xc.^2); 
zc=zeros(1,n);

%gangjin dian zuobiao
xg=-40:2.5:40;
yg=d*cos(theta)*ones(1,n)+w;
zg=d*sin(theta)*ones(1,n);

%zhuobian dao gangjin de juli:
for i=1:n
    dis(i)=norm([xc(i),yc(i),zc(i)]-[xg(i),yg(i),zg(i)]);
end

%kaicang dao banbian de juli:
for i=1:n
    margin(i)=l-yc(i)-dis(i);
end

%muban dingdian zuobiao
for i=1:n
    k=(margin(i)+dis(i))/dis(i);
    xd(i)=xc(i)+k*(xg(i)-xc(i));
    yd(i)=yc(i)+k*(yg(i)-yc(i));
    zd(i)=zc(i)+k*(zg(i)-zc(i));
end

figure(1); hold on;
plot3(xc,yc,zc,'*');
plot3(xg,yg,zg,'r');
for i=1:n
    line([xc(i),xg(i)],[yc(i),yg(i)],[zc(i),zg(i)],'LineWidth',2);
    line([xd(i),xg(i)],[yd(i),yg(i)],[zd(i),zg(i)],'LineWidth',2);
end

figure(1); hold on;
plot3(xc,-yc,zc,'*');
plot3(xg,-yg,zg,'r');
for i=1:n
    line([xc(i),xg(i)],[-yc(i),-yg(i)],[zc(i),zg(i)],'LineWidth',1,'Color',[.2 .2 .2]);
    line([xd(i),xg(i)],[-yd(i),-yg(i)],[zd(i),zg(i)],'LineWidth',1,'Color',[.2 .2 .2]);
end

plot3(xc,yc,zc);plot3(xc,-yc,zc);
line([xc(1),xc(1)],[yc(1),-yc(1)],[zc(1),zc(1)],'LineWidth',2);
line([xc(n),xc(n)],[yc(n),-yc(n)],[zc(n),zc(n)],'LineWidth',2);
view(3)

[X,Y,Z]=sphere(30);
X=l*X/2;Y=l*Y/2;Z=zeros(31);
surf(X,Y,Z);
colormap(spring);
alpha(.5)
shading interp; axis equal; axis off;