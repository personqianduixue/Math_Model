function [mu, B] = clg_Mstep_simple(w, Y, YY, YTY, X, XX, XY)
% CLG_MSTEP_SIMPLE Same as CLG_MSTEP, but doesn;t estimate Sigma,  so is slightly faster
% function [mu, B] = clg_Mstep_simple(w, Y, YY, YTY, X, XX, XY)
%
% See clg_Mstep for details.
% Unlike clg_Mstep, there are no optional arguments, which are slow to process
% if this function is inside a tight loop.

[Ysz Q] = size(Y);

if isempty(X) % no regression
  %B = [];
  B2 = zeros(Ysz, 1, Q);
  for i=1:Q
    B(:,:,i) = B2(:,1:0,i); % make an empty array of size Ysz x 0 x Q
  end
  [mu, Sigma] = mixgauss_Mstep(w, Y, YY, YTY);
  return;
end

N = sum(w);
%YY = YY + cov_prior; % regularize the scatter matrix

% Set any zero weights to one before dividing
% This is valid because w(i)=0 => Y(:,i)=0, etc
w = w + (w==0);

Xsz = size(X,1);
% Append 1 to X to get Z
ZZ = zeros(Xsz+1, Xsz+1, Q);
ZY = zeros(Xsz+1, Ysz, Q);
for i=1:Q
  ZZ(:,:,i) = [XX(:,:,i)  X(:,i);
	       X(:,i)'    w(i)];
  ZY(:,:,i) = [XY(:,:,i);
	       Y(:,i)'];
end

mu = zeros(Ysz, Q);
B = zeros(Ysz, Xsz, Q);
for i=1:Q
  % eqn 9
  if rcond(ZZ(:,:,i)) < 1e-10
    sprintf('clg_Mstep warning: ZZ(:,:,%d) is ill-conditioned', i);
    %probably because there are too few cases for a high-dimensional input
    ZZ(:,:,i) = ZZ(:,:,i) + 1e-5*eye(Xsz+1);
  end
  %A = ZY(:,:,i)' * inv(ZZ(:,:,i));
  A = (ZZ(:,:,i) \ ZY(:,:,i))';
  B(:,:,i) = A(:, 1:Xsz);
  mu(:,i) = A(:, Xsz+1);
end
