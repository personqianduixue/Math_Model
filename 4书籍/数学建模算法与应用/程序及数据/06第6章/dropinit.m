function yinit=dropinit(x);
yinit=[sqrt(1-x.^2);-x./(0.1+sqrt(1-x.^2))];
