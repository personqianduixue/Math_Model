x=@(s,t) 3*sec(s)*cos(t);
y=@(s,t) 3*sec(s)*sin(t);
z=@(s,t) 2*tan(s);
ezmesh(x,y,z)
