function y=newldown(x,ldownmu,ldownsigma)
global ldownmu ldownsigma;
y=normcdf(x,ldownmu,ldownsigma);
