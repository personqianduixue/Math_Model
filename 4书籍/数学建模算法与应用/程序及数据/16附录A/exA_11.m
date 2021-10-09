x=1:20; y=1:10; z=-10:10;
[x,y,z]=meshgrid(x,y,z);
v=x.^2.*y.*(z+1);
isosurface(x,y,z,v)
