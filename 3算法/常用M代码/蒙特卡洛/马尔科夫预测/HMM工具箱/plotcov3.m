% PLOTCOV3 - Plots a covariance ellipsoid with axes for a trivariate
%            Gaussian distribution.
%
% Usage:
%   [h, s] = plotcov3(mu, Sigma[, OPTIONS]);
% 
% Inputs:
%   mu    - a 3 x 1 vector giving the mean of the distribution.
%   Sigma - a 3 x 3 symmetric positive semi-definite matrix giving
%           the covariance of the distribution (or the zero matrix).
%
% Options:
%   'conf'      - a scalar between 0 and 1 giving the confidence
%                 interval (i.e., the fraction of probability mass to
%                 be enclosed by the ellipse); default is 0.9.
%   'num-pts'   - if the value supplied is n, then (n + 1)^2 points
%                 to be used to plot the ellipse; default is 20.
%   'plot-opts' - a cell vector of arguments to be handed to PLOT3
%                 to contol the appearance of the axes, e.g., 
%                 {'Color', 'g', 'LineWidth', 1}; the default is {}
%   'surf-opts' - a cell vector of arguments to be handed to SURF
%                 to contol the appearance of the ellipsoid
%                 surface; a nice possibility that yields
%                 transparency is: {'EdgeAlpha', 0, 'FaceAlpha',
%                 0.1, 'FaceColor', 'g'}; the default is {}
% 
% Outputs:
%   h     - a vector of handles on the axis lines
%   s     - a handle on the ellipsoid surface object
%
% See also: PLOTCOV2

% Copyright (C) 2002 Mark A. Paskin
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
% USA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [h, s] = plotcov3(mu, Sigma, varargin)

if size(Sigma) ~= [3 3], error('Sigma must be a 3 by 3 matrix'); end
if length(mu) ~= 3, error('mu must be a 3 by 1 vector'); end

[p, ...
 n, ...
 plot_opts, ...
 surf_opts] = process_options(varargin, 'conf', 0.9, ...
					'num-pts', 20, ...
			                'plot-opts', {}, ...
			                'surf-opts', {});
h = [];
holding = ishold;
if (Sigma == zeros(3, 3))
  z = mu;
else
  % Compute the Mahalanobis radius of the ellipsoid that encloses
  % the desired probability mass.
  k = conf2mahal(p, 3);
  % The axes of the covariance ellipse are given by the eigenvectors of
  % the covariance matrix.  Their lengths (for the ellipse with unit
  % Mahalanobis radius) are given by the square roots of the
  % corresponding eigenvalues.
  if (issparse(Sigma))
    [V, D] = eigs(Sigma);
  else
    [V, D] = eig(Sigma);
  end
  if (any(diag(D) < 0))
    error('Invalid covariance matrix: not positive semi-definite.');
  end
  % Compute the points on the surface of the ellipsoid.
  t = linspace(0, 2*pi, n);
  [X, Y, Z] = sphere(n);
  u = [X(:)'; Y(:)'; Z(:)'];
  w = (k * V * sqrt(D)) * u;
  z = repmat(mu(:), [1 (n + 1)^2]) + w;

  % Plot the axes.
  L = k * sqrt(diag(D));
  h = plot3([mu(1); mu(1) + L(1) * V(1, 1)], ...
	    [mu(2); mu(2) + L(1) * V(2, 1)], ...
	    [mu(3); mu(3) + L(1) * V(3, 1)], plot_opts{:});
  hold on;
  h = [h; plot3([mu(1); mu(1) + L(2) * V(1, 2)], ...
		[mu(2); mu(2) + L(2) * V(2, 2)], ...
		[mu(3); mu(3) + L(2) * V(3, 2)], plot_opts{:})];
  h = [h; plot3([mu(1); mu(1) + L(3) * V(1, 3)], ...
		[mu(2); mu(2) + L(3) * V(2, 3)], ...
		[mu(3); mu(3) + L(3) * V(3, 3)], plot_opts{:})];
end

s = surf(reshape(z(1, :), [(n + 1) (n + 1)]), ...
	 reshape(z(2, :), [(n + 1) (n + 1)]), ...
	 reshape(z(3, :), [(n + 1) (n + 1)]), ...
	 surf_opts{:});

if (~holding) hold off; end
