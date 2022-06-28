function [sol,val] = gaMichEval(sol,options)
val = 21.5 + sol(1) * sin(4*pi*sol(1)) + sol(2)*sin(20*pi*sol(2));
%G=zeros(0);
%val = sqrt(sol(1)) * sin(2*sol(1)) + sqrt(sol(1))*cos(5*sol(1))+5;
