function [ Wt ] = weight( t,T,H,F0,Kmax )
% t:age£¬T:temperature£¬H:humidity£¬F0:saturated food£¬Kmax:growth rate
    if(nargin<5)
        Kmax=10;
    end
    if(nargin<4)
        Kmax=10;
        F0 = 100000;
    end
    if(nargin<3)
        Kmax=10;
        F0 = 100000;
        H = 60;
    end
    if(nargin<2)
        Kmax=10;
        F0 = 100000;
        H = 60;
        T = 30;
    end
F=Find_F(T,H,F0);
M = 5.*t.*log(t.^5.*F);
Wt=weight1(t,M,Kmax);
end

function Wt=weight1(t,M,Kmax)
% if(nargin<1)
%     M=100;
%     Kmax=10;
%     t=0:1:100;
% end
Wt=M.*(1-exp(-Kmax.*t)).^3;
% if(nargin<1)
%     plot(t,Wt,'r','linewidth',1.5)
% end
end

function F=Find_F(T,H,F0)
% F0:saturated food
% T:temperature£¬T0:optimum temperature
% H:humidity£¬H0:optimum humidity
a_H=0.25;
a_T=0.25;
T0=30;
H0=60;
b_H=1000;
b_T=10000;
N1=(a_H/(sqrt(2*pi))).*exp(-(H-H0).^2/(2*b_H.^2));
N2=(a_T/(sqrt(2*pi))).*exp(-(T-T0).^2/(2*b_T.^2));
F=N1.*N2.*F0;
end
