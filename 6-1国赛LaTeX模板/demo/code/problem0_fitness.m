function Dt=problem0_fitness(x)
global T15 T06 T07 T89 T1011 v deltat
global ts l a b  d deltax
global T_real index
global Data
global len0 len1 len2 len3 len4 len5

alpha=x(1:5);beta=x(6);
Tt_model=getTt(alpha,beta);
Dt=sum((T_real-Tt_model(index)').^2);