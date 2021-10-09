function p = eval_pdf_clg(X,Y,mu,Sigma,W)
% function p = eval_pdf_clg(X,Y,mu,Sigma,W)
%
% p(c,t) = N(Y(:,t); mu(:,c) + W(:,:,c)*X(:,t), Sigma(:,:,c))

[d T] = size(Y);
[d nc] = size(mu);
p = zeros(nc,T);
for c=1:nc
  denom = (2*pi)^(d/2)*sqrt(abs(det(Sigma(:,:,c))));
  M = repmat(mu(:,c), 1, T) + W(:,:,c)*X;
  mahal = sum(((Y-M)'*inv(Sigma(:,:,c))).*(Y-M)',2); 
  p(c,:) = (exp(-0.5*mahal) / denom)';
end
