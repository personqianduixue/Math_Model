% # of sample points
n_samples = 1000;

p = ones(3,1)/3;

% Low Entropy
alpha = 0.5*p;

% High Entropy
%alpha = 10*p;

% draw n_samples random points from the 3-d dirichlet(alpha),
% and plot the results
points = zeros(3,n_samples);
for i = 1:n_samples
    points(:,i) = dirichletrnd(alpha);
end

scatter3(points(1,:)', points(2,:)', points(3,:)', 'r', '.', 'filled');