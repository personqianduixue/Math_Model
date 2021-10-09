clear
Lh=83.2624;
h=70;
yuliu=5;
zcwz=45;
y=-37.5:2.5:-2.5;
x=-sqrt(40^2-y.^2);
x=[-yuliu,x];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
l=x-(-Lh);
k=Lh-yuliu-zcwz;
yo=-k*h/(Lh-yuliu);
xo=-sqrt(k^2-yo^2)+x(1);
d=sqrt((xo-x).^2+yo^2);
xx1=(xo-x).*(l-d)./d+xo;
yy1=yo.*(l-d)./d+yo;
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
