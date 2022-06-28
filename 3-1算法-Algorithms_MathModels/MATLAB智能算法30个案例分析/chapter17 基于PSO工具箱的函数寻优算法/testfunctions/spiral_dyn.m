% spiral_dyn.m
% returns x,y position along an archimedean spiral of degree n
% based on cputime, first time it is called is start time
%
% based on: r = a*(theta^n)
%
% usage: [x_cnt,y_cnt] = spiral_dyn(n,a)
% i.e., 
%   n =  2 (Fermat)
%     =  1 (Archimedes)
%     = -1 (Hyberbolic)
%     = -2 (Lituus)

% Brian Birge
% Rev 1.1
% 8/23/04

function [x_cnt,y_cnt] = spiral_dyn(n,a)
 % this keeps the same start time for each run of the calling function 
 % this will reset when any calling prog is re-saved or workspace is
 % cleared
  persistent tnot iter
 % find starting time
  if ~exist('tnot') | length(tnot)==0
     tnot = cputime;
   %  iter = 0;
  end
  %iter = iter+10 ;
  
 theta = cputime-tnot;
 %theta = iter/10000;
 
 r = a*(theta.^n);
 
 x_cnt = r*cos(theta);
 y_cnt = r*sin(theta);
 return