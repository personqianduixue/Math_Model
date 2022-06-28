% NDparabola.m
% ND Parabola function (also called a Sphere function and DeJong's f1),
% described by Clerc...
% http://clerc.maurice.free.fr/pso/Semi-continuous_challenge/Semi-continuous_challenge.htm
%
% used to test optimization/global minimization problems 
% in Clerc's "Semi-continuous challenge"
%
% f(x) = sum( x.^2 )
% 
% x = N element row vector containing [x0, x1, ..., xN]
% each row is processed independently,
% you can feed in matrices of timeXN no prob
%
% example: cost = NDparabola([1,2;5,6;0,-50])
% note: known minimum =0 @ all x = 0

% Brian Birge
% Rev 1.0
% 9/12/04

function [out]=NDparabola(in)
 out = sum(in.^2, 2);