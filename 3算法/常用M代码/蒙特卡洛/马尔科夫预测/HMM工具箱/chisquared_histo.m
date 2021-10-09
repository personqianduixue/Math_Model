function s = chisquared_histo(h1, h2)
% Measure distance between 2 histograms (small numbers means more similar)
denom = h1 + h2;
denom = denom + (denom==0);
s = sum(((h1 - h2) .^ 2) ./ denom);
