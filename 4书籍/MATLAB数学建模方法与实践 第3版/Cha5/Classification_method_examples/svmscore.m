function f = svmscore(svm,X)
% Compute SVM score for classes -1 and +1

% Copyright 2014 The MathWorks, Inc.

shift = svm.ScaleData.shift;
scale = svm.ScaleData.scaleFactor;

X = bsxfun(@plus,X,shift);
X = bsxfun(@times,X,scale);

sv = svm.SupportVectors;
alphaHat = svm.Alpha;
bias = svm.Bias;
kfun = svm.KernelFunction;
kfunargs = svm.KernelFunctionArgs;

f = kfun(sv,X,kfunargs{:})'*alphaHat(:) + bias;
f = -f; % flip the sign to get the score for the +1 class

end
