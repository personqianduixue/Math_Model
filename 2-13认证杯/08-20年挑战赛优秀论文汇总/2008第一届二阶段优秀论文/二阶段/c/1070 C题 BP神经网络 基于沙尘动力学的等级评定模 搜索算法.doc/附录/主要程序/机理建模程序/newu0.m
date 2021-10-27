function y=newu0(x,u0mu,u0sigma)
global u0mu u0sigma;
y=normcdf(x,u0mu,u0sigma);
