function [isOK,up_xielv,down_xielv,t_between150_190,t_up217,maxT]=condition(T)
global deltat
DT=[0,(T(2:end)-T(1:end-1))/deltat];
up_xielv=DT(DT>0);
down_xielv=DT(DT<0);
t_between150_190=(length(T(DT>0&T>150&T<190))-1)*deltat;
t_up217=(length(T(T>217))-1)*deltat;
maxT=max(T);
isOK=1;
if ~isempty(up_xielv)&&~isempty(down_xielv)
    if max(up_xielv)>3||max(down_xielv)<-3
        isOK=0;
    end
else
    isOK=0;
end
if t_between150_190<60||t_between150_190>120
    isOK=0;
end
if t_up217<40||t_up217>90
    isOK=0;
end
if maxT<240||maxT>250
    isOK=0;
end

