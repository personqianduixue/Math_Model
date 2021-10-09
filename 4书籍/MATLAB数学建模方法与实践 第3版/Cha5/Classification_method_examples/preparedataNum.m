function [ XtrainNN, YtrainNN, XtestNN, YtestNN] = preparedataNum( bank, catPred, cv )
%preparedataNum Prepare predictors/response for Neural Networks
%   When using neural networks the appropriate way to include categorical
%   predictors is as dummy indicator variables. An indicator variable has
%   values 0 and 1.

% Copyright 2014 The MathWorks, Inc.

% |dummyvar| accepts a numeric or categorical column vector (predictor
% variable), and returns a matrix of indicator variables. The dummy
% variable design matrix has a column for every group, and a row for every
% observation.

% Continuous predictors
X1 = table2array(varfun(@double, bank(:,~catPred)));

% Each categorical predictor converted into dummy indicator variables
X2 = [];
categoricalPred = find(catPred);
for i = 1:length(categoricalPred)
    cP = table2array(varfun(@double,bank(:,categoricalPred(i))));
    X2 = [X2 dummyvar(cP)];  %#ok<AGROW>
end

% Predictor matrix
X = [X1 X2];

% Response
Y = double(bank.y) - 1;

% Use the same partition for cross validation
% Training set
XtrainNN = X(training(cv),:);
YtrainNN = Y(training(cv),:);
% Test set
XtestNN = X(test(cv),:);
YtestNN = Y(test(cv),:);

end

