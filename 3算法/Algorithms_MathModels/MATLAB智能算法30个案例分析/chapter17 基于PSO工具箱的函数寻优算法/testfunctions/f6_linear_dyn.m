% f6_linear_dyn.m
% Schaffer's F6 function
% commonly used to test optimization/global minimization problems
%
% This version moves the minimum linearly along a 45 deg angle in x,y space

% Brian Birge
% Rev 1.0
% 9/12/04

function [out]=f6_linear_dyn(in)
 % parse input
  x = in(:,1);
  y = in(:,2);
 
 % find current minimum based on clock
  offset   = linear_dyn(.5); % this is in 'hiddenutils'
  x_center = offset;
  y_center = offset;
 
  num = sin(sqrt((x-x_center).^2+(y-y_center).^2)).^2 - 0.5;
  den = (1.0+0.01*((x-x_center).^2+(y-y_center).^2)).^2;

  out = 0.5 + num./den;
  return