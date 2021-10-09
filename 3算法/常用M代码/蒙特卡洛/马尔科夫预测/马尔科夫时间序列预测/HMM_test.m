%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ①定义一个HMM并训练这个HMM。
% ②用一组观察值测试这个HMM，计算该组观察值域HMM的匹配度。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O：观察状态数
O = 3;
% Q：HMM状态数
Q = 4;
%训练的数据集,每一行数据就是一组训练的观察值
data=[1,2,3,1,2,2,1,2,3,1,2,3,1;
      1,2,3,1,2,2,1,2,3,1,2,3,1;
      1,2,3,1,2,2,1,2,3,1,2,3,1;
      1,2,3,1,2,2,1,2,3,1,2,3,1;
      1,2,3,1,2,2,1,2,3,1,2,3,1;
      1,2,3,1,2,2,1,2,3,1,2,3,1;
      1,2,3,1,2,2,1,2,3,1,2,3,1;
      1,2,3,1,2,2,1,2,3,1,2,3,1;
      1,2,3,1,2,2,1,2,3,1,2,3,1;
      1,2,3,1,2,2,1,2,3,1,2,3,1;]
% initial guess of parameters
% 初始化参数
prior1 = normalise(rand(Q,1));
transmat1 = mk_stochastic(rand(Q,Q));
obsmat1 = mk_stochastic(rand(Q,O));
% improve guess of parameters using EM
% 用data数据集训练参数矩阵形成新的HMM模型
[LL, prior2, transmat2, obsmat2] = dhmm_em(data, prior1, transmat1, obsmat1, 'max_iter', size(data,1));
% 训练后那行观察值与HMM匹配度
LL
% 训练后的初始概率分布
prior2
% 训练后的状态转移概率矩阵
transmat2
% 观察值概率矩阵
obsmat2
% use model to compute log likelihood
data1=[1,2,3,1,2,2,1,2,3,1,2,3,1]
loglik = dhmm_logprob(data1, prior2, transmat2, obsmat2)
% log lik is slightly different than LL(end), since it is computed after the final M step
% loglik 代表着data和这个hmm(三参数为prior2, transmat2, obsmat2)的匹配值，越大说明越匹配，0为极大值。
% path为viterbi算法的结果，即最大概率path
B = multinomial_prob(data1,obsmat2);
path = viterbi_path(prior2, transmat2, B)
save('sa.mat');