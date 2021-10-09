% DeJong_f3.m
% De Jong's f3 function, ND, also called STEP
% from: http://www.cs.rpi.edu/~hornda/pres/node4.html
%
% f(x) = sum( floor(x) )
%
% x = N element row vector containing [ x0, x1,..., xN ]
%   each row is processed independently,
%   you can feed in matrices of timeXN no prob
%
% example: cost = DeJong_f3([1,2;3,4;5,6])
% note minimum @ x= -Inf or whatever lower bound you've chosen

% Brian Birge
% Rev 1.0
% 9/12/04

function [out]=DeJong_f3(in)
 out = sum( floor(in) , 2);