%% rastrigrin function
[x,y]=meshgrid(-5:0.1:5,-5:0.1:5);
     z=x.^2+y.^2-10*cos(2*pi*x)-10*cos(2*pi*y)+20;
     mesh(x,y,z)