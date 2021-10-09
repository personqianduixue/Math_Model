clear;clc;close
A=load('InfoUD.mat');
P=100;
B=[];
B(:,1)=A.node1;
B(:,2)=A.node2;
if ~all(all(B(:,1:2)));
    B(:,1:2)=B(:,1:2)+1;
end
num=max(max(B));
C=zeros(num);
n=length(B);
for i=1:n
    C(B(i,1),B(i,2))=C(B(i,1),B(i,2))+1;
end
C=C+C';
R=get_degree_correlation(C);
[M,N_DeD,N_predict,DeD,aver_DeD]=Degree_Distribution(C,P);
%D=[];
%% 构建模型
%设该系统有j个节点
%设该系统有m条边
N_predict=floor(N_predict);
j=sum(N_predict);
D=[];
for k=1:P+1
    D=[D (k-1)*ones(1,N_predict(k))];
end
%S_xy = sort_reform(B,DeD);



    







    
