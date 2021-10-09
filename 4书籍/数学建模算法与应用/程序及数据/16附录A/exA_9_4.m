x=@(s,t) 3*tan(s)*cos(t);
y=@(s,t) 2*tan(s)*sin(t);
z=@(s,t) tan(s);
ezsurf(x,y,z)
