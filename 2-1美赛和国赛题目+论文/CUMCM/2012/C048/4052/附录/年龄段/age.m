y=[194 59 265 874 3138 8692 14888 21556 11280 826];
x={'1-10','11-20','21-30','31-40','41-50','51-60','61-70','71-80','81-90','91-100'};
bar(y,'group')
set(gca,'XTickLabel',x);
for ii=1:10
text(ii,y(ii)+0.5,num2str(y(ii)),'VerticalAlignment','bottom',...
    'HorizontalAlignment','center');
end