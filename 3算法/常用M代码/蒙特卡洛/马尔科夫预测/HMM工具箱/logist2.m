function [beta,p,lli] = logist2(y,x,w)
% [beta,p,lli] = logist2(y,x) 
%
% 2-class logistic regression.  
%
% INPUT
% 	y 	Nx1 colum vector of 0|1 class assignments
% 	x 	NxK matrix of input vectors as rows
% 	[w]	Nx1 vector of sample weights 
%
% OUTPUT
% 	beta 	Kx1 column vector of model coefficients
% 	p 	Nx1 column vector of fitted class 1 posteriors
% 	lli 	log likelihood
%
% Class 1 posterior is 1 / (1 + exp(-x*beta))
%
% David Martin <dmartin@eecs.berkeley.edu> 
% April 16, 2002

% Copyright (C) 2002 David R. Martin <dmartin@eecs.berkeley.edu>
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License as
% published by the Free Software Foundation; either version 2 of the
% License, or (at your option) any later version.
% 

% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
% 02111-1307, USA, or see http://www.gnu.org/copyleft/gpl.html.

error(nargchk(2,3,nargin));

% check inputs
if size(y,2) ~= 1,
  error('Input y not a column vector.');
end
if size(y,1) ~= size(x,1), 
  error('Input x,y sizes mismatched.'); 
end

% get sizes
[N,k] = size(x);

% if sample weights weren't specified, set them to 1
if nargin < 3, 
  w = 1;
end

% normalize sample weights so max is 1
w = w / max(w);

% initial guess for beta: all zeros
beta = zeros(k,1);

% Newton-Raphson via IRLS,
% taken from Hastie/Tibshirani/Friedman Section 4.4.
iter = 0;
lli = 0;
while 1==1,
  iter = iter + 1;
  
  % fitted probabilities
  p = 1 ./ (1 + exp(-x*beta));	
  
  % log likelihood
  lli_prev = lli;
  lli = sum( w .* (y.*log(p+eps) + (1-y).*log(1-p+eps)) );

  % least-squares weights
  wt = w .* p .* (1-p);		

  % derivatives of likelihood w.r.t. beta
  deriv = x'*(w.*(y-p));

  % Hessian of likelihood w.r.t. beta
  % hessian = x'Wx, where W=diag(w)
  % Do it this way to be memory efficient and fast.
  hess = zeros(k,k);
  for i = 1:k,
    wxi = wt .* x(:,i);
    for j = i:k,
      hij = wxi' * x(:,j);
      hess(i,j) = -hij;
      hess(j,i) = -hij;
    end
  end

  % make sure Hessian is well conditioned
  if (rcond(hess) < eps), 
    error(['Stopped at iteration ' num2str(iter) ...
           ' because Hessian is poorly conditioned.']);
    break; 
  end;

  % Newton-Raphson update step
  step = hess\deriv;
  beta = beta - step;

  % termination criterion based on derivatives
  tol = 1e-6;
  if abs(deriv'*step/k) < tol, break; end;

  % termination criterion based on log likelihood
%   tol = 1e-4;
%   if abs((lli-lli_prev)/(lli+lli_prev)) < 0.5*tol, break; end;
end;

