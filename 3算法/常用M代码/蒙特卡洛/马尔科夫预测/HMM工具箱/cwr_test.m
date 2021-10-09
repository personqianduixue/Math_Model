% Verify that my code gives the same results as the 1D example at
% http://www.media.mit.edu/physics/publications/books/nmm/files/cwm.m

seed = 0;
rand('state', seed);
randn('state', seed);
x = (-10:10)';
y = double(x > 0);
npts = length(x);
plot(x,y,'+')

nclusters = 4;
nplot = 100;
xplot = 24*(1:nplot)'/nplot - 12;

mux = 20*rand(1,nclusters) - 10;
muy = zeros(1,nclusters);
varx = ones(1,nclusters);
vary = ones(1,nclusters);
pc = 1/nclusters * ones(1,nclusters);


I = repmat(eye(1,1), [1 1 nclusters]);
O = repmat(zeros(1,1), [1 1 nclusters]);
X = x(:)';
Y = y(:)';

% Do 1 iteration of EM

%cwr = cwr_em(X, Y, nclusters, 'muX', mux, 'muY', muy,  'SigmaX', I, 'cov_typeX', 'spherical', 'SigmaY', I, 'cov_typeY', 'spherical', 'priorC', pc, 'weightsY', O,  'init_params', 0, 'clamp_weights', 1, 'max_iter', 1, 'cov_priorX', zeros(1,1,nclusters), 'cov_priorY', zeros(1,1,nclusters));

cwr = cwr_em(X, Y, nclusters, 'muX', mux, 'muY', muy,  'SigmaX', I, 'cov_typeX', 'spherical', 'SigmaY', I, 'cov_typeY', 'spherical', 'priorC', pc, 'weightsY', O,  'create_init_params', 0, 'clamp_weights', 1, 'max_iter', 1);


% Check this matches Gershenfeld's code

% E step
% px(t,c) = prob(x(t) | c)
px = exp(-(kron(x,ones(1,nclusters)) ...
	   - kron(ones(npts,1),mux)).^2 ...
	 ./ (2*kron(ones(npts,1),varx))) ...
     ./ sqrt(2*pi*kron(ones(npts,1),varx));
py = exp(-(kron(y,ones(1,nclusters)) ...
	   - kron(ones(npts,1),muy)).^2 ...
	 ./ (2*kron(ones(npts,1),vary))) ...
     ./ sqrt(2*pi*kron(ones(npts,1),vary));
p = px .* py .* kron(ones(npts,1),pc);
pp = p ./ kron(sum(p,2),ones(1,nclusters));

% M step
eps = 0.01;
pc2 = sum(pp)/npts;

mux2 = sum(kron(x,ones(1,nclusters)) .* pp) ...
      ./ (npts*pc2);
varx2 = eps + sum((kron(x,ones(1,nclusters)) ...
		  - kron(ones(npts,1),mux2)).^2 .* pp) ...
       ./ (npts*pc2);
muy2 = sum(kron(y,ones(1,nclusters)) .* pp) ...
      ./ (npts*pc2);
vary2 = eps + sum((kron(y,ones(1,nclusters)) ...
		  - kron(ones(npts,1),muy2)).^2 .* pp) ...
       ./ (npts*pc2);


denom = (npts*pc2);
% denom(c) = N*pc(c) = w(c) = sum_t pp(c,t)
% since pc(c) = sum_t pp(c,t) / N

cwr_mux = cwr.muX;
assert(approxeq(mux2, cwr_mux))
cwr_SigmaX = squeeze(cwr.SigmaX)';
assert(approxeq(varx2, cwr_SigmaX))

cwr_muy = cwr.muY;
assert(approxeq(muy2, cwr_muy))
cwr_SigmaY = squeeze(cwr.SigmaY)';
assert(approxeq(vary2, cwr_SigmaY))


