function y=newsta(x,stamu,stasigma)
global stamu stasigma;
y=normcdf(x,stamu,stasigma);
