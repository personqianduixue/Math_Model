%canshu
w=2.5;
r=sqrt(100+1)*w;
l=60-w;
d=l/2;
h=53-3;
theta=asin(h/l);

%shengcheng canshu 
v=-25:25;
u=25:60;
[u,v]=meshgrid(u,v);

%qumian canshu fangcheng
x=v;
y=sqrt(r^2-v.^2)+(d*cos(theta)+w-sqrt(r^2-v.^2)).*(u-sqrt(r^2-v.^2))./sqrt(d^2-+w^2+r^2-v.^2-2*(d*cos(theta)+w)*sqrt(r^2-v.^2)+2*d*w*cos(theta));
z=d*sin(theta)*(u-sqrt(r^2-v.^2))./sqrt(d^2-+w^2+r^2-v.^2-2*(d*cos(theta)+w)*sqrt(r^2-v.^2)+2*d*w*cos(theta));
z=-z;

%cemian tuxiang
figure(1);
mesh(x,y,z);

%zhuojiao bianyuanxian
u=60;
v=-25:25;
x=v;
y=sqrt(r^2-v.^2)+(d*cos(theta)+w-sqrt(r^2-v.^2)).*(u-sqrt(r^2-v.^2))./sqrt(d^2-+w^2+r^2-v.^2-2*(d*cos(theta)+w)*sqrt(r^2-v.^2)+2*d*w*cos(theta));
z=d*sin(theta)*(u-sqrt(r^2-v.^2))./sqrt(d^2-+w^2+r^2-v.^2-2*(d*cos(theta)+w)*sqrt(r^2-v.^2)+2*d*w*cos(theta));
z=-z;
figure(2);
plot3(x,y,z,'LineWidth',2);
grid on;