function comparisonPlot( Cmat, labels )
%comparisonPlot Visualize misclassification rate

% Copyright 2014 The MathWorks, Inc.

[nRows, nCols] = size(Cmat);

% Change shape of Cmat so that it is suitable for plotBarStackGroups
Cmat = reshape(Cmat,[nRows * 2, nCols / 2])';
Cmat = Cmat(:,[1 4 3 2]);
Cmat = reshape(Cmat,[nCols/2, 2, 2]);

% Use file submitted from a user at MATLAB Central to plot groups of
% stacked bars
% labels = {'NN','GLM','DA','KNN', 'NB'};
% hold on
h = plotBarStackGroups(Cmat,labels);
colors = 'bcrm';
for i = 1:numel(h)
    set(h(i),'FaceColor',colors(i));
end
ylabel('Percentage')
title({'Bank Marketing Campaign','Misclassification Rate'},'FontWeight','bold')
ylim([0 101])
legend({'No','Misclassified','Yes','Misclassified'},'Location','EastOutside')
rotateXLabels( gca, 60 );
set(gca,'Unit','normalized','Position',[0.13 0.3 0.6 0.6])
set(gca,'Color','none')

end

