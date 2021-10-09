% Rastrigin.m
% Rastrigin function
%
% used to test optimization/global minimization problems 
%
% f(x) = sum([x.^2-10*cos(2*pi*x) + 10], 2);
% 
% x = N element row vector containing [x0, x1, ..., xN]
% each row is processed independently,
% you can feed in matrices of timeXN no prob
%
% example: cost = Rastrigin([1,2;5,6;0,-50])
% note: known minimum =0 @ all x = 0

% Brian Birge
% Rev 1.0
% 9/12/04

function [out]=Rastrigin(in)

 cos_in = cos(2*pi*in);
 out    = sum((in.^2-10*cos_in + 10), 2);