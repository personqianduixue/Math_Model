function [muXY, SigmaXY] = condGaussToJoint(muX, SigmaX, muY, SigmaY, WYgivenX)

% Compute P(X,Y) from P(X) * P(Y|X) where P(X)=N(X;muX,SigmaX) 
% and P(Y|X) = N(Y; WX + muY, SigmaY)

% For details on how to compute a Gaussian from a Bayes net
% - "Gaussian Influence Diagrams", R. Shachter and C. R. Kenley, Management Science, 35(5):527--550, 1989.

% size(W) = dy x dx
dx = length(muX);
dy = length(muY);
muXY = [muX(:); WYgivenX*muX(:) + muY];

W = [zeros(dx,dx) WYgivenX';
     zeros(dy,dx) zeros(dy,dy)];
D = [SigmaX       zeros(dx,dy);
     zeros(dy,dx) SigmaY];

U = inv(eye(size(W)) - W')';
SigmaXY = U' * D * U;


