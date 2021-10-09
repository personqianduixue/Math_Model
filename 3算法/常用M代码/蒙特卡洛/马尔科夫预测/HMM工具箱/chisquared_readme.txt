From ftp://ftp.mathworks.com/pub/contrib/v4/stats/chisquared/

Chi-squared probability function.

Abstract 
m-files to compute the Chi-squared probability function, and
the percentage points of the probability function.

P = CHISQUARED_PROB( X2, v ) returns P(X2|v), the probability
of observing a chi-squared value <= X2 with v degrees of freedom.
This is the probability that the sum of squares of v unit-variance
normally-distributed random variables is <= X2.

Conversely:
X2 = CHISQUARED_TABLE( P, v ) returns the X2, the value of
chi-squared corresponding to v degrees of freedom and probability P.

In reference textbooks, what is normally tabulated are the
percentage points of the chi-squared distribution; thus, one
would use CHISQUARED_TABLE rather than interpolate such a table.

References: Press et al., Numerical Recipes, Cambridge, 1986;
Abramowitz & Stegun, Handbook of Mathematical Functions,
Dover, 1972;  Table 26.8

Peter R. Shaw
Woods Hole Oceanographic Institution, Woods Hole, MA 02543
(508) 457-2000 ext. 2473
pshaw@whoi.edu

--FILES GENERATED--
README_chisq
chisquared_prob.m  (function) -- chi-squared probability function
chisquared_table.m  (function) -- "percentage points" (i.e., inverse)
                                   of chi-squared probability function
chiaux.m (function) -- auxiliary fn. used by chisquared_table
