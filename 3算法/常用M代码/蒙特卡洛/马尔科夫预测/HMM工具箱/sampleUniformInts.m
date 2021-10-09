function M = sampleUniformInts(N, r, c)

% M is an rxc matrix of integers in 1..N

prob = normalize(ones(N,1));
M = sample_discrete(prob, r, c);
