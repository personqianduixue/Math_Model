x=@(s,t) 3*sec(s);
y=@(s,t) 2*tan(s)*cos(t);
z=@(s,t) 2*tan(s)*sin(t);
ezmesh(x,y,z)
