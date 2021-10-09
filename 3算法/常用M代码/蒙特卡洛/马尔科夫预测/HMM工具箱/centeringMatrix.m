N = 3;
x = rand(N,2); % each row is a feature vector 
m = mean(x,1);
xc = x-repmat(m, N, 1);

C = eye(N) - (1/N)*ones(N,N);
xc2 = C*x;
assert(approxeq(xc, xc2))
