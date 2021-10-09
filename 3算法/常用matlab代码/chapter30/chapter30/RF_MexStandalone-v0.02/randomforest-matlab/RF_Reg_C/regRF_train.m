%**************************************************************
%* mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
%* Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
%* License: GPLv2
%* Version: 0.02 
%
% Calls Regression Random Forest
% A wrapper matlab file that calls the mex file
% This does training given the data and labels 
% Documentation copied from R-packages pdf 
% http://cran.r-project.org/web/packages/randomForest/randomForest.pdf 
% Tutorial on getting this working in tutorial_ClassRF.m
%%**************************************************************
% function model = classRF_train(X,Y,ntree,mtry, extra_options)
% 
%___Options
% requires 2 arguments and the rest 3 are optional
% X: data matrix
% Y: target values 
% ntree (optional): number of trees (default is 500). also if set to 0
%           will default to 500
% mtry (default is floor(sqrt(size(X,2))) D=number of features in X). also if set to 0
%           will default to 500
%
%
% Note: TRUE = 1 and FALSE = 0 below
% extra_options represent a structure containing various misc. options to
%      control the RF
%  extra_options.replace = 0 or 1 (default is 1) sampling with or without
%                           replacement
%  extra_options.strata = (not Implemented)
%  extra_options.sampsize =  Size(s) of sample to draw. For classification, 
%                   if sampsize is a vector of the length the number of strata, then sampling is stratified by strata, 
%                   and the elements of sampsize indicate the numbers to be drawn from the strata. I don't yet know how this works.
%  extra_options.nodesize = Minimum size of terminal nodes. Setting this number larger causes smaller trees
%                   to be grown (and thus take less time). Note that the default values are different
%                   for classification (1) and regression (5).
%  extra_options.importance =  Should importance of predictors be assessed?
%  extra_options.localImp = Should casewise importance measure be computed? (Setting this to TRUE will
%                   override importance.)
%  extra_options.proximity = Should proximity measure among the rows be calculated?
%  extra_options.oob_prox = Should proximity be calculated only on 'out-of-bag' data?
%  extra_options.do_trace = If set to TRUE, give a more verbose output as randomForest is run. If set to
%                   some integer, then running output is printed for every
%                   do_trace trees.
%  extra_options.keep_inbag = Should an n by ntree matrix be returned that keeps track of which samples are
%                   'in-bag' in which trees (but not how many times, if sampling with replacement)
%  extra_options.corr_bias = which happens only for regression. perform bias correction for regression? Note: Experimental. Use at your own
%                   risk.
%  extra_options.nPerm = Number of times the OOB data are permuted per tree for assessing variable
%                   importance. Number larger than 1 gives slightly more stable estimate, but not
%                   very effective. Currently only implemented for regression.
%
%
%___Returns model which has
% importance =  a matrix with nclass + 2 (for classification) or two (for regression) columns.
%       For classification, the first nclass columns are the class-specific measures
%       computed as mean decrease in accuracy. The nclass + 1st column is the
%       mean decrease in accuracy over all classes. The last column is the mean decrease
%       in Gini index. For Regression, the first column is the mean decrease in
%       accuracy and the second the mean decrease in MSE. If importance=FALSE,
%       the last measure is still returned as a vector.
% importanceSD = The ?standard errors? of the permutation-based importance measure. For classification,
%       a p by nclass + 1 matrix corresponding to the first nclass + 1
%       columns of the importance matrix. For regression, a length p vector.
% localImp = a p by n matrix containing the casewise importance measures, the [i,j] element
%       of which is the importance of i-th variable on the j-th case. NULL if
%       localImp=FALSE.
% ntree = number of trees grown.
% mtry  = number of predictors sampled for spliting at each node.
% votes (classification only) a matrix with one row for each input data point and one
%       column for each class, giving the fraction or number of ?votes? from the random
%       forest.
% oob_times number of times cases are 'out-of-bag' (and thus used in computing OOB error
%       estimate)
% proximity if proximity=TRUE when randomForest is called, a matrix of proximity
%       measures among the input (based on the frequency that pairs of data points are
%       in the same terminal nodes).
% errtr = first column is OOB Err rate, second is for class 1 and so on
% mse =(regression only) vector of mean square errors: sum of squared residuals divided
%        by n.
% rsq (regression only) 'pseudo R-squared': 1 - mse / Var(y).


function model=regRF_train(X,Y,ntree,mtry, extra_options)
	%function model = regRF_predict(X,Y,ntree,mtry)
    %requires 2 arguments and the rest 2 are optional
    %X: data matrix
    %Y: target values
    %ntree (optional): number of trees (default is 500)
    %mtry (default is max(floor(D/3),1) D=number of features in X)
    DEBUG_ON=0;
    
    
    DEFAULTS_ON=0;
    
    TRUE=1;
    FALSE=0;
    
    
    if exist('extra_options','var')
        if isfield(extra_options,'DEBUG_ON');  DEBUG_ON = extra_options.DEBUG_ON;    end
        if isfield(extra_options,'replace');  replace = extra_options.replace;       end
        if isfield(extra_options,'classwt');  classwt = extra_options.classwt;       end
        if isfield(extra_options,'cutoff');  cutoff = extra_options.cutoff;       end
        if isfield(extra_options,'strata');  strata = extra_options.strata;       end
        if isfield(extra_options,'sampsize');  sampsize = extra_options.sampsize;       end
        if isfield(extra_options,'nodesize');  nodesize = extra_options.nodesize;       end
        if isfield(extra_options,'importance');  importance = extra_options.importance;       end
        if isfield(extra_options,'localImp');  localImp = extra_options.localImp;       end
        if isfield(extra_options,'nPerm');  nPerm = extra_options.nPerm;       end
        if isfield(extra_options,'proximity');  proximity = extra_options.proximity;       end
        if isfield(extra_options,'oob_prox');  oob_prox = extra_options.oob_prox;       end
        %if isfield(extra_options,'norm_votes');  norm_votes = extra_options.norm_votes;       end
        if isfield(extra_options,'do_trace');  do_trace = extra_options.do_trace;       end
        if isfield(extra_options,'corr_bias');  corr_bias = extra_options.corr_bias;       end
        if isfield(extra_options,'keep_inbag');  keep_inbag = extra_options.keep_inbag;       end
    end
    
    
    %set defaults if not already set
    if ~exist('DEBUG_ON','var')     DEBUG_ON=FALSE; end
    if ~exist('replace','var');     replace = TRUE; end
    %if ~exist('classwt','var');     classwt = []; end %will handle these three later
    %if ~exist('cutoff','var');      cutoff = 1; end    
    %if ~exist('strata','var');      strata = 1; end
    if ~exist('sampsize','var');    
        if (replace) 
            sampsize = size(X,1); 
        else
            sampsize = ceil(0.632*size(X,1));
        end; 
    end
    if ~exist('nodesize','var');    nodesize = 5; end %classification=1, regression=5
    if ~exist('importance','var');  importance = FALSE; end
    if ~exist('localImp','var');    localImp = FALSE; end
    if ~exist('nPerm','var');       nPerm = 1; end
    %if ~exist('proximity','var');   proximity = 1; end  %will handle these two later
    %if ~exist('oob_prox','var');    oob_prox = 1; end
    %if ~exist('norm_votes','var');    norm_votes = TRUE; end
    if ~exist('do_trace','var');    do_trace = FALSE; end
    if ~exist('corr_bias','var');   corr_bias = FALSE; end
    if ~exist('keep_inbag','var');  keep_inbag = FALSE; end
    
    
    if ~exist('ntree','var') | ntree<=0
		ntree=500;
        DEFAULTS_ON=1;
    end
    if ~exist('mtry','var') | mtry<0 | mtry> size(X,2)
        mtry = max(floor(size(X,2)/3),1);
        DEFAULTS_ON=1;
    end
    addclass=0;
    
    
    [N D] = size(X);
    
    if length(unique(Y))<=5,  warning('Do you want regression? there are just 5 or less unique values');  end
    if N==0,   error('Data (X) has 0 rows');  end
    if mtry<1 || mtry>D  ,  warning('Invalid mtry. reset to within valid range'); DEFAULTS_ON=1;   end
    mtry = max(1, min(D,round(mtry)));
    
    if DEFAULTS_ON
        fprintf('\tSetting to defaults %d trees and mtry=%d\n',ntree,mtry);
    end
    
    if length(Y)~=N || length(Y)==0
        error('length of Y not the same as X or Y is null');
    end
    
    if ~isempty(find(isnan(X)));  error('NaNs in X');   end
    if ~isempty(find(isnan(Y)));  error('NaNs in Y');   end
    
    %now handle categories. Problem is that categories in R are more
    %enhanced. In this i ask the user to specify the column/features to
    %consider as categories, 1 if all the values are real values else
    %specify the number of categories here
    if exist ('extra_options','var') && isfield(extra_options,'categories')
        ncat = extra_options.categories;      
    else
        ncat = ones(1,D);
    end
    
    maxcat = max(ncat);
    if maxcat>32
        error('Can not handle categorical predictors with more than 32 categories');
    end

    %classRF - line 88 in randomForest.default.R
    nclass = length(unique(Y));
    addclass = FALSE;

    if ~exist('proximity','var')
        proximity = addclass;
        oob_prox = proximity;
    end
    
    if ~exist('oob_prox','var')
        oob_prox = proximity;
    end
    
    %i handle the below in the mex file
%     if proximity
%         prox = zeros(N,N);
%         proxts = 1;
%     else
%         prox = 1;
%         proxts = 1;
%     end
    
    %i handle the below in the mex file
    if localImp
        importance = TRUE;
%        impmat = zeors(D,N);
    else
%        impmat = 1;
    end
    
    if importance
        if (nPerm<1)
            nPerm = int32(1);
        else
            nPerm = int32(nPerm);
        end
        
        %regRF
%        impout = zeros(D,2);
%        impSD  = zeros(D,1);
    else
%        impout = zeros(D,1);
%        impSD =  1;
    end
    
    %i handle the below in the mex file
    %somewhere near line 157 in randomForest.default.R
    if addclass
%        nsample = 2*n;
    else
%        nsample = n;
    end
    
    Stratify = (length(sampsize)>1);
    if (~Stratify && sampsize>N) 
        error('Sampsize too large')
    end
    
    if Stratify
        error('Sampsize should be of length one')
    end
    
    %i handle the below in the mex file
    % nrnodes = 2*floor(sampsize/max(1,nodesize-4))+1;
    % xtest = 1;
    % ytest = 1;
    % ntest = 1;
    % labelts = FALSE;
    % nt = ntree;
    
    Options = int32([importance,localImp,nPerm]);
    
    if DEBUG_ON
        %print the parameters that i am sending in
        fprintf('size(x) %d\n',size(X));
        fprintf('size(y) %d\n',size(Y));
        fprintf('nclass %d\n',nclass);
        fprintf('size(ncat) %d\n',size(ncat));
        fprintf('maxcat %d\n',maxcat);
        fprintf('size(sampsize) %d\n',size(sampsize));
        fprintf('sampsize[0] %d\n',sampsize(1));
        fprintf('Stratify %d\n',Stratify);
        fprintf('Proximity %d\n',proximity);
        fprintf('oob_prox %d\n',oob_prox);
        fprintf('ntree %d\n',ntree);
        fprintf('mtry %d\n',mtry);
        fprintf('nodesize %f\n',nodesize);
        fprintf('replace %f\n',replace);
    end
    
    
    
    
	[ldau,rdau,nodestatus,nrnodes,upper,avnode,...
        mbest,ndtree,ypred,mse,impout,impmat,...
        impSD,prox,coef,oob_times,inbag]...
        = mexRF_train (X',Y,ntree,mtry,sampsize,nodesize,...
                       int32(Options),int32(ncat),int32(maxcat),int32(do_trace), int32(proximity), int32(oob_prox), ...
                       int32(corr_bias), keep_inbag, replace    );
    
    %done in R file so doing it too.
    ypred(oob_times==0)=NaN;
	
    model.lDau=ldau;
	model.rDau=rdau;
	model.nodestatus=nodestatus;
	model.nrnodes=nrnodes;
	model.upper=upper;
	model.avnode=avnode;
	model.mbest=mbest;
	model.ndtree=ndtree;
	model.ntree = ntree;
    model.Y_hat = ypred;
    model.mse = mse;
    model.importance = impout;
    model.importanceSD = impSD;
    model.localImp = impmat;
    model.proximity = prox;
    model.coef = coef;
    model.oob_times = oob_times;
    model.inbag = inbag;
    model.nPerm = nPerm;
    model.biasCorr = corr_bias;
    model.rsq = 1 - mse / (var(Y) * (N-1) / N);
	clear mexRF_train