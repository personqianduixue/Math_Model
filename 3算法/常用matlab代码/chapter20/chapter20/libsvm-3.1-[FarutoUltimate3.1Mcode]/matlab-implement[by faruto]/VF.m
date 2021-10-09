function [score,str] = VF(true_labels,predict_labels,type)
% VF : validation_function
% Note:This tool is designed only for binary-class C-SVM with labels
% {1,-1}. Multi-class,regression and probability estimation are not supported.
% by faruto 2009.12.03
% Email:patrick.lee@foxmail.com QQ:516667408
% type : 1,2,3,4,5
% 1:Accuracy = #true / #total
% 2:Precision = true_positive / (true_positive + false_positive) 
% 3:Recall = true_positive / (true_positive + false_negative) 
% 4:F-score = 2 * Precision * Recall / (Precision + Recall) 
% 5:
% BAC (Ballanced ACcuracy) = (Sensitivity + Specificity) / 2,
% where Sensitivity = true_positive / (true_positive + false_negative)
% and   Specificity = true_negative / (true_negative + false_positive) 

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
if nargin < 3
    type = 1;
end

%% Accuracy = #true / #total
if type == 1
    Accuracy = 100*sum(predict_labels == true_labels) / numel(true_labels);
    score = Accuracy;
    str = ...
        sprintf('Accuracy = %g%% (%d/%d) [%s]',score,sum(predict_labels == true_labels),numel(true_labels),'Accuracy = #true / #total');
end

%% Precision = true_positive / (true_positive + false_positive) 
if type == 2 | type == 4
    tp = 0;
    fp = 0;
    for run = 1:numel(true_labels)
        if predict_labels(run) == 1
            if true_labels(run) == 1
                tp = tp + 1;
            else
                fp = fp + 1;
            end
        end
    end
    Precision = 100*tp/(tp+fp);
    score = Precision;
    str = ...
        sprintf('Precision = %g%% (%d/%d) [%s]',score,tp,(tp+fp),'Precision = true_positive / (true_positive + false_positive)');
end

%% Recall = true_positive / (true_positive + false_negative)
if type == 3 | type == 4
    tp = 0;
    fn = 0;
    for run = 1:numel(true_labels)
        if true_labels(run) == 1
            if predict_labels(run) == 1
                tp = tp + 1;
            else
                fn = fn + 1;
            end
        end
    end
    Recall = 100*tp/(tp+fn);
    score = Recall;
    str = ...
        sprintf('Recall = %g%% (%d/%d) [%s]',score,tp,(tp+fn),'Recall = true_positive / (true_positive + false_negative)');    
end

%% F-score = 2 * Precision * Recall / (Precision + Recall) 
if type == 4
    F_score = 2 * Precision * Recall / (Precision + Recall);
    score = F_score;
    str = ...
        sprintf('F-score = %g%% [%s]',score,'F-score = 2 * Precision * Recall / (Precision + Recall)');    
end

%% 
% BAC (Ballanced ACcuracy) = (Sensitivity + Specificity) / 2,
% where Sensitivity = true_positive / (true_positive + false_negative)
% and   Specificity = true_negative / (true_negative + false_positive) 
if type == 5
    tp = 0;
    fn = 0;
    tn = 0;
    fp = 0;
    for run = 1:numel(true_labels)
        if true_labels(run) == 1
            if predict_labels(run) == 1
                tp = tp + 1;
            else
                fn = fn + 1;
            end
        else
            if predict_labels(run) == -1
                tn = tn + 1;
            else
                fp = fp + 1;
            end
        end
    end
    Sensitivity = tp / (tp + fn);
    Specificity = tn / (tn + fp); 
    BAC = 100*(Sensitivity + Specificity) / 2;
    score = BAC;
    str = ...
        sprintf('BAC = %g%% [%s]',score,'BAC (Ballanced ACcuracy) = (Sensitivity + Specificity) / 2');    
end
