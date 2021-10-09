% f6.m
% Schaffer's F6 function
% commonly used to test optimization/global minimization problems
%
% z = 0.5+ (sin^2(sqrt(x^2+y^2))-0.5)/((1+0.01*(x^2+y^2))^2)

function [out]=f6(in)
 x=in(:,1);
 y=in(:,2);
 num=sin(sqrt(x.^2+y.^2)).^2 - 0.5;
 den=(1.0+0.01*(x.^2+y.^2)).^2;

 out=0.5 +num./den;


