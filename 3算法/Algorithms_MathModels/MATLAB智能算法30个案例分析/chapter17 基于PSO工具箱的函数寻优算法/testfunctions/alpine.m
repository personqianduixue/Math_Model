% alpine.m
% ND Alpine function, described by Clerc...
% http://clerc.maurice.free.fr/pso/Semi-continuous_challenge/Semi-continuous_challenge.htm
%
% used to test optimization/global minimization problems 
% in Clerc's "Semi-continuous challenge"
%
% f(x) = sum( abs(x.*sin(x) + 0.1.*x) )
% 
% x = N element row vector containing [x0, x1, ..., xN]
% each row is processed independently,
% you can feed in matrices of timeXN no prob
%
% example: cost = alpine([1,2;5,6;0,-50])
% note: known minimum =0 @ all x = 0

% Brian Birge
% Rev 1.0
% 9/12/04

function [out]=alpine(in)

 out = sum(abs(in.*sin(in) + 0.1.*in),2);