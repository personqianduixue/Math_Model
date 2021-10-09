function kl = KLgauss(P, Q)
%The following computes D(P||Q), the KL divergence between two zero-mean
%Gaussians with covariance P and Q:
%  klDiv = -0.5*(log(det(P*inv(Q))) + trace(eye(N)-P*inv(Q)));

R = P*inv(Q);
kl = -0.5*(log(det(R))) + trace(eye(length(P))-R);

%To get MI, just set P=cov(X,Y) and Q=blockdiag(cov(X),cov(Y)).  
