% tripod.m
% 2D tripod function, described by Clerc...
% http://clerc.maurice.free.fr/pso/Semi-continuous_challenge/Semi-continuous_challenge.htm
%
% used to test optimization/global minimization problems 
% in Clerc's "Semi-continuous challenge"
%
% f(x)= [ p(x2)*(1+p(x1)) ...
%        + abs(x1 + 50*p(x2)*(1-2*p(x1)))...
%        + abs(x2 + 50*(1-2*p(x2))) ];
%
% where p(u) = 1  for u >= 0
%            = 0  else
% 
% in = 2 element row vector containing [x1, x2]
% each row is processed independently,
% you can feed in matrices of timeX2 no prob
%
% example: cost = tripod([1,2;5,6;0,-50])
% note: known minimum =0 @ (0,-50)

% Brian Birge
% Rev 1.0
% 9/12/04

function [out]=tripod(in)

 x1=in(:,1);
 x2=in(:,2);
 
 px1=((x1) >= 0);
 px2=((x2) >= 0);
 
 out= ( px2.*(1+px1) ...
       + abs(x1 + 50*px2.*(1-2*px1))...
       + abs(x2 + 50*(1-2.*px2)) );