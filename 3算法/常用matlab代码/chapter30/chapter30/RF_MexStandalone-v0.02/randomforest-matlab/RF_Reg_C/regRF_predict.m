%**************************************************************
%* mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
%* Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
%* License: GPLv2
%* Version: 0.02
%
% Calls Regression Random Forest
% A wrapper matlab file that calls the mex file
% This does prediction given the data and the model file
%**************************************************************

function Y_hat = regRF_predict(X,model)
    %function Y_hat = regRF_predict(X,model)
    %requires 2 arguments
    %X: data matrix
    %model: generated via regRF_train function
	if nargin~=2
		error('need atleast 2 parameters,X matrix and model');
	end
	
	Y_hat = mexRF_predict(X',model.lDau,model.rDau,model.nodestatus,model.nrnodes,model.upper,model.avnode,model.mbest,model.ndtree,model.ntree);
    
    if ~isempty(find(model.coef)) %for bias corr
        Y_hat = model.coef(1) + model.coef(2)*Y_hat;
    end
	clear mexRF_predict