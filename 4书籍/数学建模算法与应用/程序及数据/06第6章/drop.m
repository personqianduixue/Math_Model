function yprime=drop(x,y);
yprime=[y(2);(y(1)-1)*(1+y(2)^2)^(3/2)];
