% f6mod.m
% Schaffer's F6 function
% commonly used to test optimization/global minimization problems
%
% This version is a modified form, just the sum of 5 f6 functions with
% different centers to look at local minimum issues
% normal f6=
% z = 0.5+ (sin^2(sqrt(x^2+y^2))-0.5)/((1+0.01*(x^2+y^2))^2)

function [out]=f6mod(in)
 x=in(:,1);
 y=in(:,2);
 a=ones(size(x));
 b=20;

 xycntr=[0*a,0*a,-b*a,-b*a,-b*a,b*a,b*a,-b*a,b*a,b*a];
 tmpout=0.*a;
 
 for i=1:5   
  num=sin(sqrt( (x-xycntr(:,2*i-1)).^2 + (y-xycntr(:,2*i)).^2) ).^2 - 0.5;
  den=(1.0+0.01*((x-xycntr(:,2*i-1)).^2+(y-xycntr(:,2*i)).^2)).^2;
  tmpout=[tmpout, 0.5*a +num./den];
 end

 out=sum(tmpout,2)./5;
 return