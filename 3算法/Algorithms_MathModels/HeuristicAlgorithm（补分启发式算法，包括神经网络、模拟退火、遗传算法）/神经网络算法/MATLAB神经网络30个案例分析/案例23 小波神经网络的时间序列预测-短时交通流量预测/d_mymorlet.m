function y=d_mymorlet(t)

y = -1.75*sin(1.75*t).*exp(-(t.^2)/2)-t* cos(1.75*t).*exp(-(t.^2)/2) ;
