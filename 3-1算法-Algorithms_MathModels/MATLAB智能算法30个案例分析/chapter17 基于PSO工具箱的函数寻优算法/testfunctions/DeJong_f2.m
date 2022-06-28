% DeJong_f2.m
% De Jong's f2 function, also called a Rosenbrock Variant
% This is a 2D only equation
%
% described by Clerc in ...
% http://clerc.maurice.free.fr/pso/Semi-continuous_challenge/Semi-continuous_challenge.htm
%
% used to test optimization/global minimization problems 
% in Clerc's "Semi-continuous challenge"
%
% f(x,y) = 100*(x.^2 - y).^2 + (1-x).^2;
%
% input = 2 element row vector containing [x, y]
%   each row is processed independently,
%   you can feed in matrices of timeXN no prob
%
% example: cost = DeJong_f2([1,2;3,4;5,6])
% note minimum =0 @ (1,1)

% Brian Birge
% Rev 1.0
% 9/12/04
function [out]=DeJong_f2(in)
 
 x= in(:,1);
 y= in(:,2);

 out = 100*(x.^2 - y).^2 + (1-x).^2;