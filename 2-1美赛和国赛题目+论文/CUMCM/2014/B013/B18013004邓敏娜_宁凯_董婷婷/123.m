clear
h=50;
yuliu=3;
y=-22.5:2.5:-2.5;
x=-sqrt(25^2-y.^2);
x=[-yuliu,x];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
l=x-(-60);
xo=-sqrt((l(1)/2)^2-(h/2)^2)+x(1);
yo=-0.5*h;
d=sqrt((xo-x).^2+yo^2);
xx1=(xo-x).*(l-d)./d+xo;
yy1=yo.*(l-d)./d+yo;
%xx2=xx(length(xx):-1:1);
%yy2=yy(length(yy):-1:1);
%xx1=[xx,xx2];
%yy1=[yy,yy2];
xx2=xx1-3*(0-yy1)./(sqrt((x-xx1).^2+(yy1).^2));
yy2=yy1+3*(x-xx1)./(sqrt((x-xx1).^2+(yy1).^2));
xx3=x-3*(0-yy1)./(sqrt((x-xx1).^2+(yy1).^2));
yy3=0+3*(x-xx1)./(sqrt((x-xx1).^2+(yy1).^2));
%xx2=xx1-3*(x-xx1)./(sqrt((x-xx1).^2+(yy1).^2));
%yy2=yy1+3*(0-yy1)./(sqrt((x-xx1).^2+(yy1).^2));
%xx3=x-3*(x-xx1)./(sqrt((x-xx1).^2+(yy1).^2));
%yy3=0+3*(0-yy1)./(sqrt((x-xx1).^2+(yy1).^2));

for i=1:length(xx1)
    plot([xx1(i),x(i)],[yy1(i),0]);
    hold on
end 
for i=1:length(xx1)
    plot([xx2(i),xx3(i)],[yy2(i),yy3(i)]);
    hold on
end    
for i=1:length(xx1)
    plot([xx2(i),xx1(i)],[yy2(i),yy1(i)]);
    hold on
end    
for i=1:length(xx1)
    plot([xx3(i),x(i)],[yy3(i),0]);
    hold on
end   
for i=1:length(xx1)
    plot([-xx1(i),-x(i)],[yy1(i),0]);
    hold on
end 
for i=1:length(xx1)
    plot([-xx2(i),-xx3(i)],[yy2(i),yy3(i)]);
    hold on
end    
for i=1:length(xx1)
    plot([-xx2(i),-xx1(i)],[yy2(i),yy1(i)]);
    hold on
end    
for i=1:length(xx1)
    plot([-xx3(i),-x(i)],[yy3(i),0]);
    hold on
end 
for i=1:length(x)
    plot([-x(i),x(i)],[0,0]);hold on;
    plot([-x(i),x(i)],[3,3]);hold on;
    plot([x(i),x(i)],[0,3]);hold on;
    plot([-x(i),-x(i)],[0,3]);hold on;
end   
axis equal
