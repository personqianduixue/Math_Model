function X2 = chisquared_table(P,v)
%CHISQUARED_TABLE computes the "percentage points" of the
%chi-squared distribution, as in Abramowitz & Stegun Table 26.8
%   X2 = CHISQUARED_TABLE( P, v ) returns the value of chi-squared 
%   corresponding to v degrees of freedom and probability P.
%   P is the probability that the sum of squares of v unit-variance
%   normally-distributed random variables is <= X2.
%   P and v may be matrices of the same size size, or either 
%   may be a scalar.
%
%   e.g., to find the 95% confidence interval for 2 degrees
%   of freedom, use CHISQUARED_TABLE( .95, 2 ), yielding 5.99,
%   in agreement with Abramowitz & Stegun's Table 26.8
%
%   This result can be checked through the function
%   CHISQUARED_PROB( 5.99, 2 ), yielding 0.9500
%
%   The familiar 1.96-sigma confidence bounds enclosing 95% of
%   a 1-D gaussian is found through 
%   sqrt( CHISQUARED_TABLE( .95, 1 )), yielding 1.96
%
%   See also CHISQUARED_PROB
%
%Peter R. Shaw, WHOI
%Leslie Rosenfeld, MBARI

% References: Press et al., Numerical Recipes, Cambridge, 1986;
% Abramowitz & Stegun, Handbook of Mathematical Functions, Dover, 1972.

% Peter R. Shaw, Woods Hole Oceanographic Institution
% Woods Hole, MA 02543  pshaw@whoi.edu
% Leslie Rosenfeld, MBARI
% Last revision: Peter Shaw, Oct 1992: fsolve with version 4

% ** Calls function CHIAUX  **
% Computed using the Incomplete Gamma function,
% as given by Press et al. (Recipes) eq. (6.2.17)

[mP,nP]=size(P);
[mv,nv]=size(v);
if mP~=mv | nP~=nv, 
  if mP==1 & nP==1,
    P=P*ones(mv,nv);
  elseif mv==1 & nv==1,
    v=v*ones(mP,nP);
  else
    error('P and v must be the same size')
  end
end
[m,n]=size(P);  X2 = zeros(m,n);
for i=1:m,
 for j=1:n,
  if v(i,j)<=10, 
   x0=P(i,j)*v(i,j);
  else
   x0=v(i,j);
  end
% Note: "old" and "new" calls to fsolve may or may not follow 
% Matlab version 3.5 -> version 4 (so I'm keeping the old call around...)
%   X2(i,j) = fsolve('chiaux',x0,zeros(16,1),[v(i,j),P(i,j)]); %(old call)
   X2(i,j) = fsolve('chiaux',x0,zeros(16,1),[],[v(i,j),P(i,j)]);
 end
end
