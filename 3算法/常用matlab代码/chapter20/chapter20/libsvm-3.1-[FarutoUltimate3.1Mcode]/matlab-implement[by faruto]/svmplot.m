function svmplot(labels,dataset,model,demension1,demension2)
% svmplot by faruto

%%
% by faruto
%Email:patrick.lee@foxmail.com QQ:516667408 http://blog.sina.com.cn/faruto BNU
%last modified 2010.01.17

%% Èô×ªÔØÇë×¢Ã÷£º
% faruto and liyang , LIBSVM-farutoUltimateVersion 
% a toolbox with implements for support vector machines based on libsvm, 2009. 
% 
% Chih-Chung Chang and Chih-Jen Lin, LIBSVM : a library for
% support vector machines, 2001. Software available at
% http://www.csie.ntu.edu.tw/~cjlin/libsvm
%%
if nargin == 3
    demension1 = 1;
    demension2 = 2;
end

%%
minX = min(dataset(:, demension1));
maxX = max(dataset(:, demension1));
minY = min(dataset(:, demension2));
maxY = max(dataset(:, demension2));

gridX = (maxX - minX) ./ 100;
gridY = (maxY - minY) ./ 100;

minX = minX - 10 * gridX;
maxX = maxX + 10 * gridX;
minY = minY - 10 * gridY;
maxY = maxY + 10 * gridY;

[bigX, bigY] = meshgrid(minX:gridX:maxX, minY:gridY:maxY);

%%

model.Parameters(1) = 3; 
ntest=size(bigX, 1) * size(bigX, 2);
test_dataset=[reshape(bigX, ntest, 1), reshape(bigY, ntest, 1)];
test_label = zeros(size(test_dataset,1), 1);

[Z, acc] = svmpredict(test_label, test_dataset, model);

bigZ = reshape(Z, size(bigX, 1), size(bigX, 2));

%%
figure;
clf;
hold on;
grid on;

ispos = ( labels == labels(1) );
pos = find(ispos);
neg = find(~ispos);

h1 = plot(dataset(pos, demension1), dataset(pos, demension2), 'r+');
h2 = plot(dataset(neg, demension1), dataset(neg, demension2), 'g*');
h3 = plot( model.SVs(:,demension1),model.SVs(:,demension2),'o' );
legend([h1,h2,h3],'class1','class2','Support Vectors');

[C,h] = contour(bigX, bigY, bigZ,-1:0.5:1);
clabel(C,h,'Color','r');
xlabel('demension1','FontSize',12);
ylabel('demension2','FontSize',12);
title('The visualization of classification','FontSize',12);