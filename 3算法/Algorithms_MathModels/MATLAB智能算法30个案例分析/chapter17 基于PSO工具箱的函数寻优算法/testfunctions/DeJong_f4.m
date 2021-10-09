% DeJong_f4.m
% De Jong's f4 function, ND, no noise
%
% described by Clerc in ...
% http://clerc.maurice.free.fr/pso/Semi-continuous_challenge/Semi-continuous_challenge.htm
%
% used to test optimization/global minimization problems 
% in Clerc's "Semi-continuous challenge"
%
% f(x) = sum( [1:N].*(in.^4), 2)
%
% x = N element row vector containing [ x0, x1,..., xN ]
%   each row is processed independently,
%   you can feed in matrices of timeXN no prob
%
% example: cost = DeJong_f4([1,2;3,4;5,6])
% note minimum =0 @ x= all zeros

% Brian Birge
% Rev 1.0
% 9/12/04
function [out]=DeJong_f4(in)
 persistent D tlen d

% this speeds routine up a lot, if called from PSO these won't change from
% call to call (repmat is a cpu hog)
 Dx=length(in(1,:));
 tlenx=length(in(:,1));
 if isempty(D) | D~=Dx | tlen~=tlenx
   D=Dx; % dimension of prob
   tlen=tlenx; % how many separate states
   d=repmat([1:D],tlen,1); % needed to vectorize this
 end
 out = sum( d.*(in.^4), 2);