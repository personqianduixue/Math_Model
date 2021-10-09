x=@(alpha,beta) 4*cos(alpha);
y=@(alpha,beta) (5+4*sin(alpha))*cos(beta);
z=@(alpha,beta) (5+4*sin(alpha))*sin(beta);
ezsurf(x,y,z)
