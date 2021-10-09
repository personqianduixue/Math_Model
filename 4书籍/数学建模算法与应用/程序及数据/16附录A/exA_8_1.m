alpha=[0:0.1:2*pi]'; beta=0:0.1:2*pi;
x=4*cos(alpha)*ones(size(beta));
y=(5+4*sin(alpha))*cos(beta);
z=(5+4*sin(alpha))*sin(beta);
surf(x,y,z)
