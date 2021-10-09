function Fitness=evaluateD(x)
%对称性评估
global T15 T06 T07 T89 T1011 v deltat
global ts l a b  d deltax
global len0 len1 len2 len3 len4 len5
global alpha_beta
T15=x(1);T06=x(2);T07=x(3);T89=x(4);v=x(5)/60;
ts=getTs();
len0=floor((b)/(v*deltat));
len1=floor((b+5*l+4*a)/(v*deltat));
len2=floor((b+6*l+5*a)/(v*deltat));
len3=floor((b+7*l+6*a)/(v*deltat));
len4=floor((b+9*l+8*a)/(v*deltat));
len5=floor((b+11*l+10*a+25)/(v*deltat));

if abs(T15-175)>10||abs(T06-195)>10||abs(T07-235)>10||abs(T89-255)>10
    Fitness=10000;
else
    T_Model=getTt(alpha_beta(1:5),alpha_beta(6));
    [~,maxT_index]=max(T_Model);
    up217_index=find(T_Model>217);
    up217_T=T_Model(up217_index(1):maxT_index)-217;
    up217_S=sum((up217_T(1:end-1)+up217_T(2:end))*deltat/2);
    [isOK,~,~,~,~,~]=condition(T_Model);
    chazhi=T_Model(up217_index(1):maxT_index)-T_Model((2*maxT_index-up217_index(1)):-1:maxT_index);
    D=sqrt(sum(chazhi.^2)/length(chazhi));
    if isOK && up217_S<505
        Fitness=D;
    else
        Fitness=10000;
    end
end
    
    

