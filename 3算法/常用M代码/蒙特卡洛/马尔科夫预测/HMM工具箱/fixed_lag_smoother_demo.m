% Example of fixed lag smoothing

rand('state', 1);
S = 2;
O = 2;
T = 7;
data = sample_discrete([0.5 0.5], 1, T);
transmat = mk_stochastic(rand(S,S));
obsmat = mk_stochastic(rand(S,O));
obslik = multinomial_prob(data, obsmat);
prior = [0.5 0.5]';


[alpha0, beta0, gamma0, ll0, xi0] = fwdback(prior, transmat, obslik);

w = 3;
alpha1 = zeros(S, T);
gamma1 = zeros(S, T);
xi1 = zeros(S, S, T-1);
t = 1;
b = obsmat(:, data(t));
olik_win = b; % window of conditional observation likelihoods
alpha_win = normalise(prior .* b);
alpha1(:,t) = alpha_win;
for t=2:T
  [alpha_win, olik_win, gamma_win, xi_win] = ...
      fixed_lag_smoother(w, alpha_win, olik_win, obsmat(:, data(t)), transmat);
  alpha1(:,max(1,t-w+1):t) = alpha_win;
  gamma1(:,max(1,t-w+1):t) = gamma_win;
  xi1(:,:,max(1,t-w+1):t-1) = xi_win;
end

e = 1e-1;
%assert(approxeq(alpha0, alpha1, e));
assert(approxeq(gamma0(:, T-w+1:end), gamma1(:, T-w+1:end), e));
%assert(approxeq(xi0(:,:,T-w+1:end), xi1(:,:,T-w+1:end), e));


