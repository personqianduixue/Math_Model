function test_eval_pdf_cond_mixgauss()

%Q = 10; M = 100; d = 20; T = 500;
Q = 2; M = 3; d = 4; T = 5;

mu = rand(d,Q,M);
data = randn(d,T);
%mixmat = mk_stochastic(rand(Q,M));
mixmat = mk_stochastic(ones(Q,M));

% tied scalar
Sigma = 0.01;

mu = rand(d,M,Q);
weights = mixmat';
N = M*ones(1,Q);
tic; [B, B2, D] = parzen(data, mu, Sigma, N, weights); toc
tic; [BC, B2C, DC] = parzenC(data, mu, Sigma, N); toc
approxeq(B,BC)
B2C = reshape(B2C,[M Q T]);
approxeq(B2,B2C)
DC = reshape(DC,[M Q T]);
approxeq(D,DC)


return

tic; [B, B2] = eval_pdf_cond_mixgauss(data, mu, Sigma, mixmat); toc
tic; C = eval_pdf_cond_parzen(data, mu, Sigma); toc
approxeq(B,C)

return;


mu = reshape(mu, [d Q*M]);

data = mk_unit_norm(data);
mu = mk_unit_norm(mu);
tic; D = 2 -2*(data'*mu); toc % avoid an expensive repmat
tic; D2 = sqdist(data, mu); toc
approxeq(D,D2)


% D(t,m) = sq dist between data(:,t) and mu(:,m)
mu = reshape(mu, [d Q*M]);
D = dist2(data', mu');
%denom = (2*pi)^(d/2)*sqrt(abs(det(C)));
denom = (2*pi*Sigma)^(d/2); % sqrt(det(2*pi*Sigma))
numer = exp(-0.5/Sigma  * D');
B2 = numer / denom;
B2 = reshape(B2, [Q M T]);

tic; B = squeeze(sum(B2 .* repmat(mixmat, [1 1 T]), 2)); toc

tic
A = zeros(Q,T);
for q=1:Q
  A(q,:) = mixmat(q,:) * squeeze(B2(q,:,:)); % sum over m
end
toc
assert(approxeq(A,B))

tic
A = zeros(Q,T);
for t=1:T
  A(:,t) = sum(mixmat .* B2(:,:,t), 2); % sum over m
end
toc
assert(approxeq(A,B))

    


mu = reshape(mu, [d Q M]);
B3 = zeros(Q,M,T);
for j=1:Q
  for k=1:M
    B3(j,k,:) = gaussian_prob(data, mu(:,j,k), Sigma*eye(d));
  end
end
assert(approxeq(B2, B3))

logB4 = -(d/2)*log(2*pi*Sigma) - (1/(2*Sigma))*D; % det(sigma*I) = sigma^d
B4 = reshape(exp(logB4), [Q M T]);
assert(approxeq(B4, B3))



  
% tied cov matrix

Sigma = rand_psd(d,d);
mu = reshape(mu, [d Q*M]);
D = sqdist(data, mu, inv(Sigma))';
denom = sqrt(det(2*pi*Sigma));
numer = exp(-0.5 * D);
B2 = numer / denom;
B2 = reshape(B2, [Q M T]);

mu = reshape(mu, [d Q M]);
B3 = zeros(Q,M,T);
for j=1:Q
  for k=1:M
    B3(j,k,:) = gaussian_prob(data, mu(:,j,k), Sigma);
  end
end
assert(approxeq(B2, B3))

logB4 = -(d/2)*log(2*pi) - 0.5*logdet(Sigma) - 0.5*D;
B4 = reshape(exp(logB4), [Q M T]);
assert(approxeq(B4, B3))
