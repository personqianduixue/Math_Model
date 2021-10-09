clear;
%canshu
w=2.5;h=60-3;a=1;W=60; n=W/2.5+1;s=32; 
t=pi/3;
l=w+h/sin(t);
R=sqrt(l^2+30^2);

%zhuobian dian zuobiao
xc=-30:2.5:30;
yc=32.5-abs(xc);
zc=zeros(1,n);

xd=xc;xg=xc;
ll=sqrt(R^2-xc.^2);
d=l-s;

for m=1:8
    tt=linspace(0,8,8);
    theta=tt(m)*t/8;

    %gangjin dian zuobiao
    yg=d*cos(theta)*ones(1,n)+w;
    zg=d*sin(theta)*ones(1,n);

    %zhuobian dao gangjin de juli:
    for i=1:n
        dis(i)=norm([xc(i),yc(i),zc(i)]-[xg(i),yg(i),zg(i)]);
    end

    %kaicang dao banbian de juli:
    margin=ll-yc-dis;

    %muban dingdian zuobiao
    for i=1:n
        k=(margin(i)+dis(i))/dis(i);
        yd(i)=yc(i)+k*(yg(i)-yc(i));
        zd(i)=zc(i)+k*(zg(i)-zc(i));
    end
    
    subplot(2,4,m)
    figure(1); hold on;
    plot3(xc,yc,zc,'*');
    plot3(xg,yg,zg,'r');
    for i=1:n
        line([xc(i),xg(i)],[yc(i),yg(i)],[zc(i),zg(i)],'LineWidth',2);
        line([xd(i),xg(i)],[yd(i),yg(i)],[zd(i),zg(i)],'LineWidth',2);
    end

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

    X=[0 0;-1 1;0 0];Y=[1 1;0 0;-1 -1];
    X=32.5*X;Y=32.5*Y;Z=zeros(3,2);
    surf(X,Y,Z);
    colormap(spring);
    alpha(.5)
    shading interp; axis equal; axis off;
end