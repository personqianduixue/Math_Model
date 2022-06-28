% f6_spiral_dyn.m
% Schaffer's F6 function
% commonly used to test optimization/global minimization problems
%
% This version moves the minimum about a Fermat Spiral
% according to the equation: r = a*(theta^2)
%   theta is a function of time and is checked internally (not an input)
%   x_center = r*cos(theta)
%   y_center = r*sin(theta)
%
% z =  0.5 ...
%    +(sin^2(sqrt((x-x_center)^2+(y-y_center)^2))-0.5) ...
%    /((1+0.01*((x-x_center)^2+(y-y_center)^2))^2)

% Brian Birge
% Rev 1.0
% 9/12/04

function [out]=f6_spiral_dyn(in)
 % parse input
  x = in(:,1);
  y = in(:,2);
 
 % find current minimum based on clock
  [x_center,y_center]=spiral_dyn(1,.1); % this is in 'hiddenutils'
 
  num = sin(sqrt((x-x_center).^2+(y-y_center).^2)).^2 - 0.5;
  den = (1.0+0.01*((x-x_center).^2+(y-y_center).^2)).^2;

  out = 0.5 + num./den;
  return