function y=newx2(x,x2mu,x2sigma)
global x2mu x2sigma;
y=normcdf(x,x2mu,x2sigma);
