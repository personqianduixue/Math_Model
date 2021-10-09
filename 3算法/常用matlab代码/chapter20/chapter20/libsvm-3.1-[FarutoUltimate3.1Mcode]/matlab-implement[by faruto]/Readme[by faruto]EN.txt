libsvm-mat-2.89-[FarutoUltimate3.0Mcode]
% faruto and liyang[http://blog.sina.com.cn/faruto] , LIBSVM-farutoUltimateVersion 
% a toolbox with implements for support vector machines based on libsvm, 2009. 
% 
% Chih-Chung Chang and Chih-Jen Lin, LIBSVM : a library for
% support vector machines, 2001. Software available at
% http://www.csie.ntu.edu.tw/~cjlin/libsvm

The main contents of the original implements [by faruto]:
scaleForSVM:normalization function
the handle of the function:
[train_scale,test_scale,ps] = scaleForSVM(train_data,test_data,ymin,ymax)
====================================
pcaForSVM:dimension reduction functino using pca method 
the handle of the function:
[train_pca,test_pca] = pcaForSVM(train,test,threshold)
====================================
fasticaForSVM:dimension reductino functino using ica method
the handle of the function:
[train_ica,test_ica] = fasticaForSVM(train,test)
====================================
SVMcgForClass:find best parameters for classification problem of SVM[grid search based on CV]
the handle of the function:
[bestacc,bestc,bestg] = SVMcgForClass(train_label,train,cmin,cmax,gmin,gmax,v,cstep,gstep,accstep)

SVMcgForRegress:find best parameters for regression problem of SVM[grid search based on CV]
the handle of the function:
[mse,bestc,bestg] = SVMcgForRegress(train_label,train,cmin,cmax,gmin,gmax,v,cstep,gstep,msestep)
======================================
psoSVMcgForClass:find best parameters for classification problem of SVM using pso method [pso based on CV]
the handle of the function:
[bestCVaccuracy,bestc,bestg,pso_option] = psoSVMcgForClass(train_label,train,pso_option)

psoSVMcgForRegress:find best parameters for regression problem of SVM using pso method[pso based on CV]
the handle of the function:
[bestCVmse,bestc,bestg,pso_option] = psoSVMcgForRegress(train_label,train,pso_option)
=======================================
gaSVMcgForClass:find best parameters for classification problem of SVM using ga method[ga based on CV]
the handle of the function:
[bestCVaccuracy,bestc,bestg,ga_option] = gaSVMcgForClass(train_label,train,ga_option)

gaSVMcgForRegress:find best parameters for regression problem of SVM using ga method[ga based on CV]
the handle of the function:
[bestCVmse,bestc,bestg,ga_option] = gaSVMcgForRegress(train_label,train,ga_option)
======================================
gaSVMcgpForRegress.m
psoSVMcgpForRegress.m

find best parameters (c,g,p) for regression problem using ga and pso mehtod.
======================================
Addition there is a tutorial material TutorialForFarutoUltimate3.0.pdf for using the implement function for libsvm
