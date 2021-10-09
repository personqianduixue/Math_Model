function M = sample_gaussian(mu, Sigma, N)
% SAMPLE_GAUSSIAN Draw N random row vectors from a Gaussian distribution
% samples = sample_gaussian(mean, cov, N)

if nargin==2
  N = 1;
end

% If Y = CX, Var(Y) = C Var(X) C'.
% So if Var(X)=I, and we want Var(Y)=Sigma, we need to find C. s.t. Sigma = C C'.
% Since Sigma is psd, we have Sigma = U D U' = (U D^0.5) (D'^0.5 U').

mu = mu(:);
n=length(mu);
[U,D,V] = svd(Sigma);
M = randn(n,N);
M = (U*sqrt(D))*M + mu*ones(1,N); % transform each column
M = M';

