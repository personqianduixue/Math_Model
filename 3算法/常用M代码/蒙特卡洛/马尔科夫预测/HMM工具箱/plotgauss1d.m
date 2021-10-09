function h = plotgauss1d(mu, sigma2)
% function h = plotgauss1d(mu, sigma^2)
% Example
% plotgauss1d(0,5); hold on; h=plotgauss1d(0,2);set(h,'color','r')

sigma = sqrt(sigma2);
x = linspace(mu-3*sigma, mu+3*sigma, 100);
p = gaussian_prob(x, mu, sigma2);
h = plot(x, p, '-');
