function plotBondClusters( corp, idx, title_str)
%plotBondClusters Wrapper function to plot the bond clusters utilizing
%bubbleplot

% Copyright 2014 The MathWorks, Inc.

figure
bubbleplot(double(corp.Rating), corp.Coupon, corp.YTM, [], idx);
set(gca,'XTick',double(unique(corp.Rating)))
set(gca,'XTickLabel',cellstr(unique(corp.Rating)))
ylabel('Coupon R')
zlabel('YTM')
title(title_str)
grid on

end

