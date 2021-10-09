% linear_dyn.m
% returns an offset that can be added to data that increases linearly with
% time, based on cputime, first time it is called is start time
%
% equation is: offset = (cputime - tnot)*scalefactor
%  where tnot = cputime at the first call
%        scalefactor = value that slows or speeds up linear movement
%
% usage: [offset] = linear_dyn(scalefactor)

% Brian Birge
% Rev 1.0
% 8/23/04

function out = linear_dyn(sf)
 % this keeps the same start time for each run of the calling function 
 % this will reset when any calling prog is re-saved or workspace is
 % cleared
  persistent tnot
 % find starting time
  if ~exist('tnot') | length(tnot)==0
     tnot = cputime;
  end
 
 out = (cputime-tnot)*sf;
 return