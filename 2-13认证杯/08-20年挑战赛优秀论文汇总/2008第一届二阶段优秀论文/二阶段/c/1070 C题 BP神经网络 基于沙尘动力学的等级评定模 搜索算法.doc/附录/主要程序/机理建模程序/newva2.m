function y=newva2(x,va2mu,va2sigma)
global va2mu va2sigma;
if x<0
    t1=0;t2=0;
else
t1=(x.^0.5-va2mu)/va2sigma;
t2=(-x.^0.5-va2mu)/va2sigma;
end
y=normcdf(t1,va2mu,va2sigma)-normcdf(t2,va2mu,va2sigma);
