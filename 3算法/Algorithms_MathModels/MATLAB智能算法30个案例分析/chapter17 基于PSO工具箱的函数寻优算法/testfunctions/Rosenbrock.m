% Rosenbrock.m
% Rosenbrock function
%
% described by Clerc in ...
% http://clerc.maurice.free.fr/pso/Semi-continuous_challenge/Semi-continuous_challenge.htm
%
% used to test optimization/global minimization problems 
% in Clerc's "Semi-continuous challenge"
%
% f(x) = sum([ 100*(x(i+1) - x(i)^2)^2 + (x(i) -1)^2])
% 
% x = N element row vector containing [x0, x1, ..., xN]
% each row is processed independently,
% you can feed in matrices of timeXN no prob
%
% example: cost = Rosenbrock([1,2;5,6;0,-50])
% note: known minimum =0 @ all x = 1

% Brian Birge
% Rev 1.0
% 9/12/04
function [out]=Rosenbrock(in)
 
 x0=in(:,1:end-1);
 x1=in(:,2:end);

 out = sum( (100*(x1-x0.^2).^2 + (x0-1).^2) , 2);