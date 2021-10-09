d = 2; M = 3; Q = 4; T = 5; Sigma = 10;
N = sample_discrete(normalize(ones(1,M)), 1, Q);
data = randn(d,T);
mu = randn(d,M,Q);

[BM, B2M] = parzen(data, mu, Sigma, N);
[B, B2] = parzenC(data, mu, Sigma, N);

approxeq(B,BM)
approxeq(B2,B2M)
