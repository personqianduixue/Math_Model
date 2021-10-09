%**************************************************************
%* mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
%* Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
%* License: GPLv2
%* Version: 0.02
%
% Calls Classification Random Forest
% A wrapper matlab file that calls the mex file
% This does training given the data and labels 
% Documentation copied from R-packages pdf 
% http://cran.r-project.org/web/packages/randomForest/randomForest.pdf 
% Tutorial on getting this working in tutorial_ClassRF.m
%**************************************************************
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
%  extra_options.classwt = priors of classes. Here the function first gets
%                       the labels in ascending order and assumes the
%                       priors are given in the same order. So if the class
%                       labels are [-1 1 2] and classwt is [0.1 2 3] then
%                       there is a 1-1 correspondence. (ascending order of
%                       class labels). Once this is set the freq of labels in
%                       train data also affects.
%  extra_options.cutoff (Classification only) = A vector of length equal to number of classes. The ?winning?
%                       class for an observation is the one with the maximum ratio of proportion
%                       of votes to cutoff. Default is 1/k where k is the number of classes (i.e., majority
%                       vote wins). 
%  extra_options.strata = (not yet stable in code) variable that is used for stratified
%                       sampling. I don't yet know how this works. Disabled
%                       by default
%  extra_options.sampsize =  Size(s) of sample to draw. For classification, 
%                   if sampsize is a vector of the length the number of strata, then sampling is stratified by strata, 
%                   and the elements of sampsize indicate the numbers to be
%                   drawn from the strata. 
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
%  extra_options.keep_inbag Should an n by ntree matrix be returned that keeps track of which samples are
%                   'in-bag' in which trees (but not how many times, if sampling with replacement)
%
% Options eliminated
% corr_bias which happens only for regression ommitted
% norm_votes - always set to return total votes for each class.
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

function model=classRF_train(X,Y,ntree,mtry, extra_options)
    DEFAULTS_ON =0;
    %DEBUG_ON=0;

    TRUE=1;
    FALSE=0;
    
    orig_labels = sort(unique(Y));
    Y_new = Y;
    new_labels = 1:length(orig_labels);
    
    for i=1:length(orig_labels)
        Y_new(find(Y==orig_labels(i)))=Inf;
        Y_new(isinf(Y_new))=new_labels(i);
    end
    
    Y = Y_new;
    
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
        %if isfield(extra_options,'corr_bias');  corr_bias = extra_options.corr_bias;       end
        if isfield(extra_options,'keep_inbag');  keep_inbag = extra_options.keep_inbag;       end
    end
    keep_forest=1; %always save the trees :)
    
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
    if ~exist('nodesize','var');    nodesize = 1; end %classification=1, regression=5
    if ~exist('importance','var');  importance = FALSE; end
    if ~exist('localImp','var');    localImp = FALSE; end
    if ~exist('nPerm','var');       nPerm = 1; end
    %if ~exist('proximity','var');   proximity = 1; end  %will handle these two later
    %if ~exist('oob_prox','var');    oob_prox = 1; end
    %if ~exist('norm_votes','var');    norm_votes = TRUE; end
    if ~exist('do_trace','var');    do_trace = FALSE; end
    %if ~exist('corr_bias','var');   corr_bias = FALSE; end
    if ~exist('keep_inbag','var');  keep_inbag = FALSE; end
    

    if ~exist('ntree','var') | ntree<=0
		ntree=500;
        DEFAULTS_ON=1;
    end
    if ~exist('mtry','var') | mtry<=0 | mtry>size(X,2)
        mtry =floor(sqrt(size(X,2)));
    end
    
    addclass =isempty(Y);
    
    if (~addclass && length(unique(Y))<2)
        error('need atleast two classes for classification');
    end
    [N D] = size(X);
    
    if N==0; error(' data (X) has 0 rows');end
    
    if (mtry <1 || mtry > D)
        DEFAULTS_ON=1;
    end
    
    mtry = max(1,min(D,round(mtry)));
    
    if DEFAULTS_ON
        fprintf('\tSetting to defaults %d trees and mtry=%d\n',ntree,mtry);
    end
    
    if ~isempty(Y)
        if length(Y)~=N,    
            error('Y size is not the same as X size');  
        end
        addclass = FALSE;
    else
        if ~addclass, 
            addclass=TRUE;
        end
        error('have to fill stuff here')
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
    if ~exist('cutoff','var') 
        cutoff = ones(1,nclass)* (1/nclass);
    else
        if sum(cutoff)>1 || sum(cutoff)<0 || length(find(cutoff<=0))>0 || length(cutoff)~=nclass
            error('Incorrect cutoff specified');
        end
    end
    if ~exist('classwt','var')
        classwt = ones(1,nclass);
        ipi=0;
    else
        if length(classwt)~=nclass
            error('Length of classwt not equal to the number of classes')
        end
        if ~isempty(find(classwt<=0))
            error('classwt must be positive');
        end
        ipi=1;
    end

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
        
        %classRF
%        impout = zeros(D,nclass+2);
%        impSD  = zeros(D,nclass+1);
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
        if ~exist('strata','var')
            strata = Y;
        end
        nsum = sum(sampsize);
        if ( ~isempty(find(sampsize<=0)) || nsum==0)
            error('Bad sampsize specification');
        end
    else
        nsum = sampsize;
    end
    %i handle the below in the mex file
    %nrnodes = 2*floor(nsum/nodesize)+1;
    %xtest = 1;
    %ytest = 1;
    %ntest = 1;
    %labelts = FALSE;
    %nt = ntree;
    
    
    
    
	%[ldau,rdau,nodestatus,nrnodes,upper,avnode,mbest,ndtree]=
    %keyboard
    
    
    
    if Stratify
        strata = int32(strata);
    else
        strata = int32(1);
    end
    
    Options = int32([addclass, importance, localImp, proximity, oob_prox, do_trace, keep_forest, replace, Stratify, keep_inbag]);

    
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
        fprintf('strata %d\n',strata);
        fprintf('ntree %d\n',ntree);
        fprintf('mtry %d\n',mtry);
        fprintf('ipi %d\n',ipi);
        fprintf('classwt %f\n',classwt);
        fprintf('cutoff %f\n',cutoff);
        fprintf('nodesize %f\n',nodesize);
    end    
    
    
    [nrnodes,ntree,xbestsplit,classwt,cutoff,treemap,nodestatus,nodeclass,bestvar,ndbigtree,mtry ...
        outcl, counttr, prox, impmat, impout, impSD, errtr, inbag] ...
        = mexClassRF_train(X',int32(Y_new),length(unique(Y)),ntree,mtry,int32(ncat), ... 
                           int32(maxcat), int32(sampsize), strata, Options, int32(ipi), ...
                           classwt, cutoff, int32(nodesize),int32(nsum));
 	model.nrnodes=nrnodes;
 	model.ntree=ntree;
 	model.xbestsplit=xbestsplit;
 	model.classwt=classwt;
 	model.cutoff=cutoff;
 	model.treemap=treemap;
 	model.nodestatus=nodestatus;
 	model.nodeclass=nodeclass;
 	model.bestvar = bestvar;
 	model.ndbigtree = ndbigtree;
    model.mtry = mtry;
    model.orig_labels=orig_labels;
    model.new_labels=new_labels;
    model.nclass = length(unique(Y));
    model.outcl = outcl;
    model.counttr = counttr;
    if proximity
        model.proximity = prox;
    else
        model.proximity = [];
    end
    model.localImp = impmat;
    model.importance = impout;
    model.importanceSD = impSD;
    model.errtr = errtr';
    model.inbag = inbag;
    model.votes = counttr';
    model.oob_times = sum(counttr)';
 	clear mexClassRF_train
    %keyboard
    1;

