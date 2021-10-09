t=dsolve('Dt=10000*pi/sqrt(2*g)*(h^(3/2)-2*h^(1/2))','t(1)=0','h');
t=simple(t), pretty(t)
