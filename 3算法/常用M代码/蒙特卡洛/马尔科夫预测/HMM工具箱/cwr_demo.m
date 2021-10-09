% Compare my code with
% http://www.media.mit.edu/physics/publications/books/nmm/files/index.html
%
% cwm.m
% (c) Neil Gershenfeld  9/1/97
% 1D Cluster-Weighted Modeling example
%
clear all
figure;
seed = 0;
rand('state', seed);
randn('state', seed);
x = (-10:10)';
y = (x > 0);
npts = length(x);
plot(x,y,'+')
xlabel('x')
ylabel('y')
nclusters = 4;
nplot = 100;
xplot = 24*(1:nplot)'/nplot - 12;

mux = 20*rand(1,nclusters) - 10;
muy = zeros(1,nclusters);
varx = ones(1,nclusters);
vary = ones(1,nclusters);
pc = 1/nclusters * ones(1,nclusters);
niterations = 5;
eps = 0.01;
  

I = repmat(eye(1,1), [1 1 nclusters]);
O = repmat(zeros(1,1), [1 1 nclusters]);
X = x(:)';
Y = y(:)';

cwr = cwr_em(X, Y, nclusters, 'muX', mux, 'muY', muy,  'SigmaX', I, ...
	     'cov_typeX', 'spherical', 'SigmaY', I, 'cov_typeY', 'spherical', ...
	     'priorC', pc, 'weightsY', O,  'create_init_params', 0, ...
	     'clamp_weights', 1, 'max_iter', niterations, ...
	     'cov_priorX', eps*ones(1,1,nclusters), ...
	     'cov_priorY', eps*ones(1,1,nclusters));


% Gershenfeld's EM code
for step = 1:niterations
    pplot = exp(-(kron(xplot,ones(1,nclusters)) ...
		  - kron(ones(nplot,1),mux)).^2 ...
		./ (2*kron(ones(nplot,1),varx))) ...
	    ./ sqrt(2*pi*kron(ones(nplot,1),varx)) ...
	    .* kron(ones(nplot,1),pc);
    plot(xplot,pplot,'k');
    pause(0);
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
    pc = sum(pp)/npts;
    yfit = sum(kron(ones(npts,1),muy) .* p,2) ...
	   ./ sum(p,2);
    mux = sum(kron(x,ones(1,nclusters)) .* pp) ...
	  ./ (npts*pc);
    varx = eps + sum((kron(x,ones(1,nclusters)) ...
		      - kron(ones(npts,1),mux)).^2 .* pp) ...
	   ./ (npts*pc);
    muy = sum(kron(y,ones(1,nclusters)) .* pp) ...
	  ./ (npts*pc);
    vary = eps + sum((kron(y,ones(1,nclusters)) ...
		      - kron(ones(npts,1),muy)).^2 .* pp) ...
	   ./ (npts*pc);
end


% Check equal
cwr_pc = cwr.priorC';
assert(approxeq(cwr_pc, pc))
cwr_mux = cwr.muX;
assert(approxeq(mux, cwr_mux))
cwr_SigmaX = squeeze(cwr.SigmaX)';
assert(approxeq(varx, cwr_SigmaX))
cwr_muy = cwr.muY;
assert(approxeq(muy, cwr_muy))
cwr_SigmaY = squeeze(cwr.SigmaY)';
assert(approxeq(vary, cwr_SigmaY))


% Prediction

X = xplot(:)';
[cwr_mu, Sigma, post] = cwr_predict(cwr, X);
cwr_ystd = squeeze(Sigma)';

% pplot(t,c)
pplot = exp(-(kron(xplot,ones(1,nclusters)) ...
   - kron(ones(nplot,1),mux)).^2 ...
   ./ (2*kron(ones(nplot,1),varx))) ...
   ./ sqrt(2*pi*kron(ones(nplot,1),varx)) ...
   .* kron(ones(nplot,1),pc);
yplot = sum(kron(ones(nplot,1),muy) .* pplot,2) ...
   ./ sum(pplot,2);
ystdplot = sum(kron(ones(nplot,1),(muy.^2+vary)) .* pplot,2) ...
   ./ sum(pplot,2) - yplot.^2;


% Check equal
assert(approxeq(yplot(:)', cwr_mu(:)'))
assert(approxeq(ystdplot, cwr_ystd))
assert(approxeq(pplot ./ repmat(sum(pplot,2), 1, nclusters),post') )

plot(xplot,yplot,'k');
hold on
plot(xplot,yplot+ystdplot,'k--');
plot(xplot,yplot-ystdplot,'k--');
plot(x,y,'k+');
axis([-12 12 -1 1.1]);
plot(xplot,.8*pplot/max(max(pplot))-1,'k')
hold off

