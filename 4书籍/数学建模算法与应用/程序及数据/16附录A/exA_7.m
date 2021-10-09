x=0:10:600;
[X,Y,Z]=cylinder(30*exp(-x/400).*sin((x+25*pi)/100)+130);
surf(X,Y,Z)
