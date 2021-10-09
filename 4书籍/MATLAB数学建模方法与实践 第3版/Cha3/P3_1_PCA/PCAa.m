%% PCA数据降维实例
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
%% 读取数据
A=xlsread('Coporation_evaluation.xlsx', 'B2:I16');

% Transfer orginal data to standard data
a=size(A,1);   % Get the row number of A
b=size(A,2);   % Get the column number of A
for i=1:b
    SA(:,i)=(A(:,i)-mean(A(:,i)))/std(A(:,i));  % Matrix normalization
end

% Calculate correlation matrix of A.
CM=corrcoef(SA);

% Calculate eigenvectors and eigenvalues of correlation matrix.
[V, D]=eig(CM);

% Get the eigenvalue sequence according to descending and the corrosponding
% attribution rates and accumulation rates.
for j=1:b
    DS(j,1)=D(b+1-j, b+1-j);
end
for i=1:b
    DS(i,2)=DS(i,1)/sum(DS(:,1));
    DS(i,3)=sum(DS(1:i,1))/sum(DS(:,1));
end

% Calculate the numvber of principal components.
T=0.9;  % set the threshold value for evaluating information preservation level.
for K=1:b
    if DS(K,3)>=T
        Com_num=K;
        break;
    end
end

% Get the eigenvectors of the Com_num principal components
for j=1:Com_num
    PV(:,j)=V(:,b+1-j);
end

% Calculate the new socres of the orginal items
new_score=SA*PV;

for i=1:a
    total_score(i,2)=sum(new_score(i,:));
    total_score(i,1)=i;
end
new_score_s=sortrows(total_score,-2);

%% 显示结果
disp('特征值及贡献率：')
DS
disp('阀值T对应的主成分数与特征向量：')
Com_num
PV
disp('主成分分数：')
new_score
disp('主成分分数排序：')
new_score_s















