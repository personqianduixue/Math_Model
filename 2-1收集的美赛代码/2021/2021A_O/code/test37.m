function test37
x = [0.6829 0.3914];
bar(x)
title('Effect of interaction on decomposition efficiency')
ylabel('Decomposition rate')

y = ['0','1'];
% % set(gca,'XTickLabel',{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q'});
for	ii=1:length(x)
    text(ii,-0.05,y(ii),'VerticalAlignment','bottom','HorizontalAlignment','center');
end
set(gca,'xtick',[]);
set(gca, 'FontName', 'Times New Roman');