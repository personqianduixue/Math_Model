function P = chisquared_prob(X2,v)
%CHISQUARED_PROB computes the chi-squared probability function.
%   P = CHISQUARED_PROB( X2, v ) returns P(X2|v), the probability
%   of observing a chi-squared value <= X2 with v degrees of freedom.
%   This is the probability that the sum of squares of v unit-variance
%   normally-distributed random variables is <= X2.
%   X2 and v may be matrices of the same size size, or either 
%   may be a scalar.
%   
%   e.g., CHISQUARED_PROB(5.99,2) returns 0.9500, verifying the
%   95% confidence bound for 2 degrees of freedom. This is also
%   cross-checked in, e.g., Abramowitz & Stegun Table 26.8
%
%   See also CHISQUARED_TABLE
%
%Peter R. Shaw, WHOI

% References: Press et al., Numerical Recipes, Cambridge, 1986;
% Abramowitz & Stegun, Handbook of Mathematical Functions, Dover, 1972.

% Peter R. Shaw, Woods Hole Oceanographic Institution
% Woods Hole, MA 02543
% (508) 457-2000 ext. 2473  pshaw@whoi.edu
% March, 1990; fixed Oct 1992 for version 4

% Computed using the Incomplete Gamma function,
% as given by Press et al. (Recipes) eq. (6.2.17)

% Following nonsense is necessary from Matlab version 3 -> version 4
versn_str=version; eval(['versn=' versn_str(1) ';']);
if versn<=3, %sigh
 P = gamma(v/2, X2/2);
else
 P = gammainc(X2/2, v/2);
end
