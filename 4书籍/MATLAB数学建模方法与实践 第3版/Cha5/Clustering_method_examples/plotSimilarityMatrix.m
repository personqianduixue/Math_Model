function [dist_metric_h, dist_metric_k] = plotSimilarityMatrix( bonds, dist_h, hidx, dist_k, kidx )
%plotSimilarityMatrix This function computes and plots the similarity
%matrix for hierarchical and k-means clustering.

% Copyright 2014 The MathWorks, Inc.

figure
subplot(2,1,1)
dist_metric_h = pdist(bonds,dist_h);
dd_h = squareform(dist_metric_h);
[~,idx] = sort(hidx);
dd_h = dd_h(idx,idx);
imagesc(dd_h)
ylabel('Data Point #')
title('Hierarchical Clustering')
ylabel(colorbar,['Dist Metric:', dist_h])
axis square

subplot(2,1,2)
dist_metric_k = pdist(bonds,dist_k);
dd_k = squareform(dist_metric_k);
[~,idx] = sort(kidx);
dd_k = dd_k(idx,idx);
imagesc(dd_k)
xlabel('Data Point #')
ylabel('Data Point #')
title('k-Means Clustering')
ylabel(colorbar,['Dist Metric:', dist_k])
axis square

colormap('hot')

end

