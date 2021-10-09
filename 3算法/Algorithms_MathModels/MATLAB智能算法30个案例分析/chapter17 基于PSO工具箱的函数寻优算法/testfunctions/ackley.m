% ackley.m
% Ackley's function, from http://www.cs.vu.nl/~gusz/ecbook/slides/16
% and further shown at: 
% http://clerc.maurice.free.fr/pso/Semi-continuous_challenge/Semi-continuous_challenge.htm
%
% commonly used to test optimization/global minimization problems
%
% f(x)= [ 20 + e ...
%        -20*exp(-0.2*sqrt((1/n)*sum(x.^2,2))) ...
%        -exp((1/n)*sum(cos(2*pi*x),2))];
%
% dimension n = # of columns of input, x1, x2, ..., xn
% each row is processed independently,
% you can feed in matrices of timeXdim no prob
%
% example: cost = ackley([1,2,3;4,5,6])

% Brian Birge
% Rev 1.0
% 9/12/04

function [out]=ackley(in)

% dimension is # of columns of input, x1, x2, ..., xn
 n=length(in(1,:));

 x=in;
 e=exp(1);

 out = (20 + e ...
       -20*exp(-0.2*sqrt((1/n).*sum(x.^2,2))) ...
       -exp((1/n).*sum(cos(2*pi*x),2)));
 return