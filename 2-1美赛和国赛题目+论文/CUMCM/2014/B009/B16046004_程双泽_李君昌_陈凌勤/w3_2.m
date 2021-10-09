clear;
%canshu
w=2.5;h=70-3;W=90; n=W/2.5-1;s=40; 
t=pi*70/180;

%zhuobian dian zuobiao
xc=-42.5:2.5:42.5;
yc=sqrt(30^2-(abs(xc)-15).^2);
zc=zeros(1,n);

l=yc(1)+h/sin(t);
xd=xc;xg=xc;
d=l-s;

for m=1:8
    theta=m*t/8;

    %gangjin dian zuobiao
    yg=d*cos(theta)*ones(1,n)+w;
    zg=d*sin(theta)*ones(1,n);

    %zhuobian dao gangjin de juli:
    for i=1:n
        dis(i)=norm([xc(i),yc(i),zc(i)]-[xg(i),yg(i),zg(i)]);
    end

    %kaicang dao banbian de juli:
    margin=l-yc-dis;

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

    [X,Y,Z]=sphere(30);
    X=30*X;Y=30*Y;Z=zeros(31);
    X=X+15;    surf(X,Y,Z);
    X=X-30;    surf(X,Y,Z);
    colormap(spring);
    alpha(.5)
    shading interp; axis equal; axis off;
end