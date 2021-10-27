function y=newqa(x,qamu,qasigma)
global qamu qasigma;
y=normcdf(x,qamu,qasigma);
