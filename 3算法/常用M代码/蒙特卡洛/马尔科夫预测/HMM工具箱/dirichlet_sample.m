function theta = dirichlet_sample(alpha, N)
% SAMPLE_DIRICHLET Sample N vectors from Dir(alpha(1), ..., alpha(k))
% theta = sample_dirichlet(alpha, N)
% theta(i,j) = i'th sample of theta_j, where theta ~ Dir

% We use the method from p. 482 of "Bayesian Data Analysis", Gelman et al.

assert(alpha > 0);
k = length(alpha);
theta = zeros(N, k);
scale = 1; % arbitrary
for i=1:k
  %theta(:,i) = gamrnd(alpha(i), scale, N, 1);
  theta(:,i) = gamma_sample(alpha(i), scale, N, 1);
end
%theta = mk_stochastic(theta);
S = sum(theta,2); 
theta = theta ./ repmat(S, 1, k);
