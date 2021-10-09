%canshu
w=2.5;
r=sqrt(100+1)*w;
l=60-w;
d=l/2;
h=53-3;
theta=asin(h/l);

%zhuobian dian zuobiao
xc=-10:10;
xc=xc*w;
yc=sqrt(r^2-xc.^2);
zc=zeros(1,21);

%gangjin dian zuobiao
xg=-10:10;
xg=xg*w;
yg=d*cos(theta)*ones(1,21)+w;
zg=d*sin(theta)*ones(1,21);
 
%zhuobian dao gangjin de juli:
for i=1:21
    dis(i)=norm([xc(i),yc(i),zc(i)]-[xg(i),yg(i),zg(i)]);
end

%kaicang dao banbian de juli:
for i=1:21
    margin(i)=60-yc(i)-dis(i);
end

%muban dingdian zuobiao
for i=1:21
    k=(margin(i)+dis(i))/dis(i);
    xd(i)=xc(i)+k*(xg(i)-xc(i));
    yd(i)=yc(i)+k*(yg(i)-yc(i));
    zd(i)=zc(i)+k*(zg(i)-zc(i));
end

figure(1); hold on;
plot3(xc,yc,zc,'*','LineWidth',2);
plot3(xg,yg,zg,'r','LineWidth',2);
for i=1:21
    line([xc(i),xg(i)],[yc(i),yg(i)],[zc(i),zg(i)],'LineWidth',2);
    line([xd(i),xg(i)],[yd(i),yg(i)],[zd(i),zg(i)],'LineWidth',2);
end

figure(1); hold on;
plot3(xc,-yc,zc,'*');
plot3(xg,-yg,zg,'r');
for i=1:21
    line([xc(i),xg(i)],[-yc(i),-yg(i)],[zc(i),zg(i)],'LineWidth',1,'Color',[.2 .2 .2]);
    line([xd(i),xg(i)],[-yd(i),-yg(i)],[zd(i),zg(i)],'LineWidth',1,'Color',[.2 .2 .2]);
end

plot3(xc,yc,zc);plot3(xc,-yc,zc);
line([xc(1),xc(1)],[yc(1),-yc(1)],[zc(1),zc(1)],'LineWidth',2);
line([xc(21),xc(21)],[yc(21),-yc(21)],[zc(21),zc(21)],'LineWidth',2);
view(3)

[X,Y,Z]=sphere(30);
X=25*X;Y=25*Y;Z=zeros(31);
surf(X,Y,Z);
colormap(spring);
alpha(.5)
shading interp; axis equal; axis off;
