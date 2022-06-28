%% 适配值函数     
%输入：
%个体的长度（TSP的距离）
%输出：
%个体的适应度值
function FitnV=Fitness(len)
FitnV=1./len;
