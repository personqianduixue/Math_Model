%% 离散Hopfield的分类——高校科研能力评价

%% 清空环境变量
clear all
clc

%% 导入记忆模式
T = [-1 -1 1; 1 -1 1]';

%% 权值和阈值学习
[S,Q] = size(T);
Y = T(:,1:Q-1) - T(:,Q)*ones(1,Q-1);
[U,SS,V] = svd(Y);
K = rank(SS);

TP = zeros(S,S);
for k = 1:K
  TP = TP + U(:,k)*U(:,k)';
end

TM = zeros(S,S);
for k = K+1:S
  TM = TM + U(:,k)*U(:,k)';
end

tau = 10;
Ttau = TP - tau*TM;
Itau = T(:,Q) - Ttau*T(:,Q);

h = 0.15;
C1 = exp(h)-1;
C2 = -(exp(-tau*h) - 1)/tau;

w = expm(h*Ttau);
b = U * [  C1*eye(K)         zeros(K,S-K);
         zeros(S-K,K)  C2*eye(S-K)] * U' * Itau;
     
%% 导入待记忆的模式
Ai = [-0.7; -0.6; 0.6];
y0 = Ai;

%% 迭代计算
for i = 1:5
    for j = 1:size(y0,1)
        y{i}(j,:) = satlins(w(j,:)*y0 + b(j));
    end
    y0 = y{i};
end
y{1}