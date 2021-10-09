function [auc, hCurve] = rocplot(actual, predScore, names, posclass)
% Receiver Operating Characteristic Plot
%
% rocplot(actual, predScore, names, [posclass])

% Copyright 2014 The MathWorks, Inc.

if nargin < 4, posclass = 1; end

N = size(predScore,2);
cla;
color = lines(N);
hCurve = zeros(1,N);
auc = zeros(1,N);
for i = 1:N
%     [rocx, rocy, ~, auc(i), rocPt] = perfcurve(actual, predScore(:,i), posclass); 
%     hCurve(i) = line(rocx, rocy, 'Color', color(i,:));
%     line(rocPt(1), rocPt(2), 'Color', color(i,:), 'Marker', '.', 'MarkerSize', 3);
    
    [rocx, rocy, ~, auc(i)] = perfcurve(actual, predScore(:,i), posclass);
    hCurve(i,:) = plot(rocx, rocy, 'Color', color(i,:)); hold on;
end
legend(hCurve(:,1), names);
grid on;
title('Performance Curves (ROC) for ''yes'''); 
xlabel('False Positive Rate [ = FP/(TN+FP)]'); 
ylabel('True Positive Rate [ = TP/(TP+FN)]');