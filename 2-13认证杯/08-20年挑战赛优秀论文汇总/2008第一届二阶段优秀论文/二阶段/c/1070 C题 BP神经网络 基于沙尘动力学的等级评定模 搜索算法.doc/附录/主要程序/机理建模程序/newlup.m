function y=newlup(x,lupmu,lupsigma)
global lupmu lupsigma;
y=normcdf(x,lupmu,lupsigma);
