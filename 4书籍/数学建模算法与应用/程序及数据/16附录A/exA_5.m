x=-3:0.1:3;y=-5:0.1:5;
x1=ones(size(y'))*x;y1=y'*ones(size(x));
[x2,y2]=meshgrid(x,y);
z1=(sin(x1.*y1)+eps)./(x1.*y1+eps);
z2=(sin(x2.*y2)+eps)./(x2.*y2+eps);
subplot(1,2,1),mesh(x1,y1,z1)
subplot(1,2,2),mesh(x2,y2,z2)
