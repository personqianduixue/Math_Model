function samples = fwdprop_backsample(init_state_distrib, transmat, obslik, nsamples)

% forwards propagation, backwards sampling
%
% input
% init_state_distrib(q)
% transmat(q, q')
% obslik(q, t)
% nsamples
%
% output
% samples(t, s)  = sample s of discrete state at time  t


[Q T] = size(obslik);
scale = ones(1,T);
loglik = 0;
alpha = zeros(Q,T, 'single');
beta = zeros(Q,T,'single');
gamma = zeros(Q,T,'single');
trans = transmat;

t = 1;
alpha(:,1) = init_state_distrib(:) .* obslik(:,t);
[alpha(:,t), scale(t)] = normalise(alpha(:,t));
for t=2:T
  m = trans' * alpha(:,t-1);
  alpha(:,t) = m(:) .* obslik(:,t);
  [alpha(:,t), scale(t)] = normalise(alpha(:,t));
  assert(approxeq(sum(alpha(:,t)),1))
end
loglik = sum(log(scale));


beta = zeros(Q,T);
t=T;
beta(:,T) = ones(Q,1);
gamma(:,T) = normalize(alpha(:,T) .* beta(:,T));
if nsamples > 0
  samples(t,:) = sample(gamma(:,T), nsamples);
end
for t=T-1:-1:1
 b = beta(:,t+1) .* obslik(:,t+1);
 beta(:,t) = normalize(transmat * b);
 gamma(:,t) = normalize(alpha(:,t) .* beta(:,t));
 %xi_summed = xi_summed + normalize((transmat .* (alpha(:,t) * b')));
 if nsamples > 0
   % compute xi_{t+1|t+1}(i,j)
   xi_filtered = normalize((alpha(:,t) * obslik(:,t+1)') .* transmat);
   for n=1:nsamples
     dist = normalize(xi_filtered(:,samples(t+1,n)));
     samples(t,n) = sample(dist);
   end
 end
end


if 0
beta(:,T) = ones(Q,1);
gamma(:,T) = normalise(alpha(:,T) .* beta(:,T));
t=T;
samples = zeros(T, nsamples);
samples(t,:) = sample_discrete(gamma(:,t), 1, nsamples);
for s=1:nsamples
  for t=T-1:-1:1
    L = samples(t+1,s);
    obslikTmp = zeros(Q,1);
    obslikTmp(L) = 1;
    b = beta(:,t+1) .* obslikTmp;
    beta(:,t) = normalise(trans * b);
    gamma(:,t) = normalise(alpha(:,t) .* beta(:,t));
    samples(t,s) = sample_discrete(gamma(:,t), 1, 1);
  end
end
end
