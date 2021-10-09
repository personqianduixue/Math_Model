function plotClusterProb( numClust, corp, prob, title_str, v )
%plotClusterProb Function to interpolate and plot probability of point
%belonging to different clusters based on credit rating and coupon rate

% Copyright 2014 The MathWorks, Inc.

bonds = corp{:,{'Coupon','YTM','CurrentYield','RatingNum'}};
[X,Y] = meshgrid(linspace(min(bonds(:,4)),max(bonds(:,4)),8), linspace(min(bonds(:,1)),max(bonds(:,1)),100));
figure
warning('off','MATLAB:scatteredInterpolant:DupPtsAvValuesWarnId')
for i = 1:numClust
    subplot(numClust,1,i)
    sinterp = scatteredInterpolant(bonds(:,4),bonds(:,1), prob(:,i),'linear','nearest');
    Z = sinterp(X,Y);
    surf(X,Y,Z,'EdgeColor','none')
    shading interp
    set(gca,'XTick',double(unique(corp.Rating)))
    set(gca,'XTickLabel',cellstr(unique(corp.Rating)))
    ylabel('Coupon R')
    zlabel('Probability')
    title([title_str ': Cluster ' num2str(i)])
%     c = colorbar;
    zlim([0 1])
    if nargin > 4 && strcmp(v,'2D')
        view(2)
%         ylabel(c,'Probability')
        ylabel('Probability')
        set(gcf,'Renderer','painters')
    end
end
warning('on','MATLAB:scatteredInterpolant:DupPtsAvValuesWarnId')
end

