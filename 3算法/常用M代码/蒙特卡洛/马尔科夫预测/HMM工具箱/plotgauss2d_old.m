function h=plotgauss2d_old(mu, Sigma, plot_cross)
% PLOTGAUSS2D Plot a 2D Gaussian as an ellipse with optional cross hairs
% h=plotgauss2(mu, Sigma)
% 
% h=plotgauss2(mu, Sigma, 1) also plots the major and minor axes
%
% Example
% clf; S=[2 1; 1 2]; plotgauss2d([0;0], S, 1); axis equal

if nargin < 3, plot_cross = 0; end
[V,D]=eig(Sigma);
lam1 = D(1,1);
lam2 = D(2,2);
v1 = V(:,1);
v2 = V(:,2);
%assert(approxeq(v1' * v2, 0))
if v1(1)==0
  theta = 0; % horizontal
else
  theta = atan(v1(2)/v1(1));
end
a = sqrt(lam1);
b = sqrt(lam2);
h=plot_ellipse(mu(1), mu(2), theta, a,b);

if plot_cross
  mu = mu(:);
  held = ishold;
  hold on
  minor1 = mu-a*v1; minor2 = mu+a*v1;
  hminor = line([minor1(1) minor2(1)], [minor1(2) minor2(2)]);
  
  major1 = mu-b*v2; major2 = mu+b*v2;
  hmajor = line([major1(1) major2(1)], [major1(2) major2(2)]);
  %set(hmajor,'color','r')
  if ~held
    hold off
  end
end

