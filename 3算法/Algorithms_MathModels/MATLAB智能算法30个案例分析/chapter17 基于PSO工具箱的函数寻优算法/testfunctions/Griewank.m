% Griewank.m
% Griewank function
% described by Clerc in ...
% http://clerc.maurice.free.fr/pso/Semi-continuous_challenge/Semi-continuous_challenge.htm
%
% used to test optimization/global minimization problems 
% in Clerc's "Semi-continuous challenge"
%
% f(x) = sum((x-100).^2,2)./4000 - ...
%        prod(cos((x-100)./(sqrt(repmat([1:N],length(x(:,1),1)))),2) ...
%        +1
% 
% x = N element row vector containing [x0, x1, ..., xN]
% each row is processed independently,
% you can feed in matrices of timeXN no prob
%
% example: cost = Griewank([1,2;5,6;0,-50])
% note: known minimum =0 @ all x = 100

% Brian Birge
% Rev 1.0
% 9/12/04
function [out]=Griewank(in)
 persistent d D tlen sqrtd

% this speeds routine up a lot, if called from PSO these won't change from
% call to call
 Dx=length(in(1,:));
 tlenx=length(in(:,1));
 if isempty(D) | D~=Dx | tlen~=tlenx
   D=Dx; % dimension of prob
   tlen=tlenx; % how many separate states
   d=repmat([1:D],tlen,1); % needed to vectorize this
   sqrtd=sqrt(d);
 end

% just follows from the referenced website/paper
 term1 = sum([(in-100).^2],2)./4000;
 term2 = prod( (cos( (in-100)./sqrtd )) ,2);
 out = term1 - term2 + 1;