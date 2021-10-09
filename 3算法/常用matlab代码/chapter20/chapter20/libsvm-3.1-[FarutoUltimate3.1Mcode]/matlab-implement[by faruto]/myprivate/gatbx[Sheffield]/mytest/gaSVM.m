%% gaSVM
tic;
%%
close all;
clear;
clc;
format compact;
%%
load wine_test;
train_label = train_data_labels;
train_data = train_data;
test_label = test_data_labels;
test_data = test_data;
%%
[train_data,test_data] = scaleForSVM(train_data,test_data);
%%
MAXGEN = 100;
NIND = 20;
NVAR = 2;
PRECI = 20;
GGAP = 0.9;
trace = zeros(MAXGEN,2);

FieldID = [rep([PRECI],[1,NVAR]);[0.1,0.01;100,100];rep([1;0;1;1],[1,NVAR])];

Chrom = crtbp(NIND,NVAR*PRECI);

gen = 1;
v = 5;
BestCVaccuracy = 0;
Bestc = 0;
Bestg = 0;
%%
cg = bs2rv(Chrom,FieldID);

for nind = 1:NIND
    cmd = ['-v ',num2str(v),' -c ',num2str(cg(nind,1)),' -g ',num2str(cg(nind,2))];
    ObjV(nind,1) = svmtrain(train_label,train_data,cmd);
end
[BestCVaccuracy,I] = max(ObjV);
Bestc = cg(I,1);
Bestg = cg(I,2);

%%
while 1    
    FitnV = ranking(-ObjV);
    
    SelCh = select('sus',Chrom,FitnV,GGAP);
    SelCh = recombin('xovsp',SelCh,0.7);
    SelCh = mut(SelCh);
    
    cg = bs2rv(SelCh,FieldID);
    for nind = 1:size(SelCh,1)
        cmd = ['-v ',num2str(v),' -c ',num2str(cg(nind,1)),' -g ',num2str(cg(nind,2))];
        ObjVSel(nind,1) = svmtrain(train_label,train_data,cmd);
    end
    
    [Chrom,ObjV] = reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
    
    if max(ObjV) <= 50
        continue;
    end
    
    [NewBestCVaccuracy,I] = max(ObjV);
    cg_temp = bs2rv(Chrom,FieldID);
    temp_NewBestCVaccuracy = NewBestCVaccuracy;
    
    if NewBestCVaccuracy > BestCVaccuracy
       BestCVaccuracy = NewBestCVaccuracy;
       Bestc = cg_temp(I,1);
       Bestg = cg_temp(I,2);
    end
    
    if abs( NewBestCVaccuracy-BestCVaccuracy ) <= 10^(-2) && ...
        cg_temp(I,1) < Bestc
       BestCVaccuracy = NewBestCVaccuracy;
       Bestc = cg_temp(I,1);
       Bestg = cg_temp(I,2);
    end    
    
    trace(gen,1) = max(ObjV);
    trace(gen,2) = sum(ObjV)/length(ObjV);
    
    gen = gen+1;
    if gen <= MAXGEN/2
        continue;
    end
    if BestCVaccuracy >=80 && ...
       ( temp_NewBestCVaccuracy-BestCVaccuracy ) <= 10^(-2)     
        break;
    end
    if gen == MAXGEN
        break;
    end
end


%%
gen = gen - 1
BestCVaccuracy 
Bestc 
Bestg 
%%
figure;
hold on;
plot(trace(1:gen,1),'r*-','LineWidth',1.5);
plot(trace(1:gen,2),'o-','LineWidth',1.5);
legend('最佳适应度','平均适应度',3);
xlabel('进化代数','FontSize',12);
ylabel('适应度','FontSize',12);
axis([0 gen 0 100]);
grid on;

line1 = '适应度曲线Accuracy[GAmethod]';
line2 = ['终止代数=', ...
    num2str(gen),',种群数量pop=', ...
    num2str(NIND),')'];
line3 = ['Best c=',num2str(Bestc),' g=',num2str(Bestg), ...
    ' CVAccuracy=',num2str(BestCVaccuracy),'%'];
title({line1;line2;line3},'FontSize',12);

%%
toc;




