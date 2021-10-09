function criterion = featureImp(Xtrain,Ytrain,Xtest,Ytest,modeltype)
%featureImp This function computes the misclassification rate for a given
%modeltype.
%   SEQUENTIALFS expects one to compute the criterion which the method
%   seeks to minimize over all feasible feature subsets. In this particular
%   case, we are computing the misclassification rate. This function
%   incorporates the flexibility for one to try different models, as
%   specified by the modeltype argument.

% Copyright 2014 The MathWorks, Inc.

switch modeltype
    case 'LinearModel'
        lm = LinearModel.fit(Xtrain,double(Ytrain));
        
        Y_lm = lm.predict(Xtest);
        Y_lm = round(Y_lm);
        Y_lm(Y_lm < 1) = 1;
        Y_lm(Y_lm > 2) = 2;
        Cmat = confusionmat(double(Ytest),Y_lm);
    case 'GeneralizedLinearModel'
        glm = GeneralizedLinearModel.fit(Xtrain,double(Ytrain)-1,'linear','Distribution','binomial','link','logit');
        Y_glm = glm.predict(Xtest);
        Y_glm = round(Y_glm) + 1;
        Cmat = confusionmat(double(Ytest),Y_glm);
    case 'ClassificationDiscriminant'
        da = ClassificationDiscriminant.fit(Xtrain,Ytrain,'discrimType','linear');
        Y_da = da.predict(Xtest);
        Cmat = confusionmat(Ytest,Y_da);
    case 'ClassificationKNN'
        knn = ClassificationKNN.fit(Xtrain,Ytrain,'Distance','seuclidean',...
                            'NumNeighbors',5);
        Y_knn = knn.predict(Xtest);
        Cmat = confusionmat(Ytest,Y_knn);
    case 'NaiveBayes'
        Nb = NaiveBayes.fit(Xtrain,Ytrain);
        Y_Nb = Nb.predict(Xtest);
        Cmat = confusionmat(Ytest,Y_Nb);
    case 'svm'
        svmStruct = svmtrain(Xtrain,Ytrain,'method','LS','kernel_function','rbf');
        Y_svm = svmclassify(svmStruct,Xtest);
        Cmat = confusionmat(Ytest,Y_svm);
    case 'ClassificationTree'
        t = ClassificationTree.fit(Xtrain,Ytrain);
        Y_t = t.predict(Xtest);
        Cmat = confusionmat(Ytest,Y_t);
    case 'TreeBagger'
%         cost = [0 1
%                 5 0];
%         tb = TreeBagger(120,Xtrain,Ytrain,'method','classification','cost',cost);
        tb = TreeBagger(100,Xtrain,Ytrain,'method','classification');
        Y_tb = tb.predict(Xtest);
        Y_tb = categorical(Y_tb);
        Cmat = confusionmat(Ytest,Y_tb);
    case 'NN'
        [~, net] = NNfun(Xtrain,Ytrain);
        Y_nn = net(Xtest');
        Y_nn = round(Y_nn');
        Cmat = confusionmat(Ytest,Y_nn);
    otherwise
        error('Modeltype should be one of the following: LinearModel, GeneralizedLinearModel, ClassificationDiscriminant, ClassificationKNN, NaiveBayes, svm, ClassificationTree, TreeBagger or NN')
end

% Confusion matrix in percentage/100
Cmat = bsxfun(@rdivide,Cmat,sum(Cmat,2));

% Misclassification rate for each class
misclassification = 1 - diag(Cmat);

criterion = sum(misclassification);
%criterion = Cmat(1,2)/sum(Cmat(:,2));