function [alpha, obslik, gamma, xi] = fixed_lag_smoother(d, alpha, obslik, obsvec, transmat, act)
% FIXED_LAG_SMOOTHER Computed smoothed posterior estimates within a window given previous filtered window.
% [alpha, obslik, gamma, xi] = fixed_lag_smoother(d, alpha, obslik, obsvec, transmat, act)
%
% d >= 2 is the desired window width.
% Actually, we use d=min(d, t0), where t0 is the current time.
%
% alpha(:, t0-d:t0-1) - length d window, excluding t0 (Columns indexed 1..d)
% obslik(:, t0-d:t0-1) - length d window
% obsvec              - likelihood vector for current observation
% transmat            - transition matrix
% If we specify the optional 'act' argument, transmat{a} should be a cell array, and
% act(t0-d:t0)          - length d window, last column = current action
%
% Output:
% alpha(:, t0-d+1:t0)     - last column = new filtered estimate
% obslik(:, t0-d+1:t0)    - last column = obsvec
% xi(:, :, t0-d+1:t0-1)   - 2 slice smoothed window
% gamma(:, t0-d+1:t0)     - smoothed window
%
% As usual, we define (using T=d)
% alpha(i,t) = Pr(Q(t)=i | Y(1:t))
% gamma(i,t) = Pr(Q(t)=i | Y(1:T))
% xi(i,j,t) = Pr(Q(t)=i, Q(t+1)=j | Y(1:T))
%
% obslik(i,t) = Pr(Y(t) | Q(t)=i) 
% transmat{a}(i,j) = Pr(Q(t)=j | Q(t-1)=i, A(t)=a)

[S n] = size(alpha); 
d = min(d, n+1); 
if d < 2
  error('must keep a window of length at least 2');
end

if ~exist('act')
  act = ones(1, n+1);
  transmat = { transmat };
end

% pluck out last d-1 components from the history
alpha = alpha(:, n-d+2:n); 
obslik = obslik(:, n-d+2:n); 

% Extend window by 1
t = d;
obslik(:,t) = obsvec;
xi = zeros(S, S, d-1);
xi(:,:,t-1) = normalise((alpha(:,t-1) * obslik(:,t)') .* transmat{act(t)});
alpha(:,t) = sum(xi(:,:,t-1), 1)';

% Now smooth backwards inside the window
beta = ones(S, d);
T = d;
%fprintf('smooth from %d to 1, i.e., %d to %d\n', d, t0, t0-d+1);
gamma(:,T) = alpha(:,T);
for t=T-1:-1:1
  b = beta(:,t+1) .* obslik(:,t+1); 
  beta(:,t) = normalise(transmat{act(t)} * b);
  gamma(:,t) = normalise(alpha(:,t) .* beta(:,t));
  xi(:,:,t) = normalise((transmat{act(t)} .* (alpha(:,t) * b')));
end




