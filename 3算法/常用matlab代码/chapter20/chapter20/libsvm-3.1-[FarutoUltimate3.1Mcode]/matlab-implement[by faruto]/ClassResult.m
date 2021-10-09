function CR = ClassResult(label, data, model, type)
% by faruto
% last modified 2011.06.09
% type 1：输入的data为训练集
%      2：输入的data为测试集
% 当输入的data为训练集时，需要事先在外部将标签转换为1，-1
%%
if nargin < 4
    type = 1;
end
CR = struct();
%%
[plabel,acc,dec] = svmpredict(label,data,model);
%% some info of the data set
disp('===some info of the data set===')
str = sprintf('#class is %d',model.nr_class);
disp(str)
lstr = ['类别标签为 '];
for i = 1:size(model.Label,1)
    lstr = [lstr, num2str(model.Label(i)),' '];
end
disp(lstr);
if type == 1
    str = ...
        sprintf('支持向量数目 %d,所占训练集样本数目比例 %g%% （%d/%d）',model.totalSV,model.totalSV/size(data,1)*100,model.totalSV,size(data,1));
    disp(str);
    ratio = model.totalSV/size(data,1)*100;
    if ratio >= 80
        disp('Tips:支持向量数目所占比例过大(>=80%),可以考虑重新优化参数')
    end
else
    str = ...
        sprintf('支持向量数目 %d',model.totalSV);
    disp(str);    
end
%% 各种分类准确率
disp('===各种分类准确率===');
CR.accuracy = zeros(1,size(model.Label,1)+1);
CR.accuracy(1) = sum(plabel == label)/numel(label);
str = ...
    sprintf('整体分类准确率 = %g%% (%d/%d)',CR.accuracy(1)*100,sum(plabel == label),numel(label));
disp(str)
for i = 1:numel(model.Label)
    p = 0;
    n = 0;
    for run = 1:numel(label)
        if label(run) == model.Label(i)
            if plabel(run) == model.Label(i)
                p = p + 1;
            else
                n = n + 1;
            end
        end
    end
    CR.accuracy(i+1) = p/(p+n);
    str = ...
        sprintf('第 %d 类分类准确率 = %g%% (%d/%d)',model.Label(i),CR.accuracy(i+1)*100,p,p+n);
    disp(str);
end
%%
if type == 1
    [tmp index]=ismember(model.SVs,data,'rows');
    CR.SVlocation = index;
end
%%
if numel(model.Label) == 2 && type == 1
    CR.b = -model.rho;
    CR.w = model.sv_coef;
    CR.alpha = zeros(size(model.sv_coef,1),1);
    for i = 1:size(model.sv_coef,1)
        CR.alpha(i) = CR.w(i)/label(CR.SVlocation(i));
    end
end
