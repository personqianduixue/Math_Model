[x,y]=meshgrid([-3:0.2:3]);
z=(sin(x.*y)+eps)./(x.*y+eps);
surf(x,y,z)
