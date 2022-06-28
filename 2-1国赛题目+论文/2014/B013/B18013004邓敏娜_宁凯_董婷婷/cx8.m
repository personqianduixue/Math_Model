clear
Lh=78.7147+3;
h=70;
yuliu=3;
w=40/10;
zcwz=78.7147*(1-0.52);
y=(-40+w):w:-w;
x=-sqrt(40^2-y.^2);
x=[-yuliu,x];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
l=x-(-Lh);
k=Lh-yuliu-zcwz;
yo=-k*h/(Lh-yuliu);
xo=-sqrt(k^2-yo^2)+x(1);
d=sqrt((xo-x).^2+yo^2);
xx1=(xo-x).*(l-d)./d+xo;
yy1=yo.*(l-d)./d+yo;
kaikou1=-Lh+(l-d);
kaikou2=(zcwz-Lh)*ones(size(kaikou1));
mutiao=abs(-Lh-x);
kaikoucd=kaikou2-kaikou1;
shuju=[mutiao;kaikou1;kaikou2;kaikoucd;xx1;xo*ones(size(xx1))];
plot([0,-Lh],[-40,-40]);
hold on
for i=1:10
    plot([x(i),-Lh],[-40+w*i,-40+w*i]);hold on;
    plot([x(i),x(i)],[-40+w*i,-40+w*(i-1)]);hold on
end
plot([0,-Lh],[40,40]);
hold on
for i=1:10
    plot([x(i),-Lh],[40-w*i,40-w*i]);hold on;
    plot([x(i),x(i)],[40-w*i,40-w*(i-1)]);hold on;
end
plot([-Lh,-Lh],[-40,40]),hold on;
%===========================================
x=-x;
plot([0,Lh],[-40,-40]);
hold on
for i=1:10
    plot([x(i),Lh],[-40+w*i,-40+w*i]);hold on;
    plot([x(i),x(i)],[-40+w*i,-40+w*(i-1)]);hold on
end
plot([0,Lh],[40,40]);
hold on
for i=1:10
    plot([x(i),Lh],[40-w*i,40-w*i]);hold on;
    plot([x(i),x(i)],[40-w*i,40-w*(i-1)]);hold on;
end
plot([Lh,Lh],[-40,40]),hold on;
axis equal

for i=1:10
    plot([kaikou1(i),kaikou2(i)],[-40-w/2+w*i,-40-w/2+w*i],'r');hold on;
end

for i=1:10
    plot([kaikou1(i),kaikou2(i)],[40+w/2-w*i,40+w/2-w*i],'r');hold on;
end
kaikou1=-kaikou1;
kaikou2=-kaikou2;
for i=1:10
    plot([kaikou1(i),kaikou2(i)],[-40-w/2+w*i,-40-w/2+w*i],'r');hold on;
end

for i=1:10
    plot([kaikou1(i),kaikou2(i)],[40+w/2-w*i,40+w/2-w*i],'r');hold on;
end

