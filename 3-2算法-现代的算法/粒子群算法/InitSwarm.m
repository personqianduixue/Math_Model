function [ParSwarm,OptSwarm]=InitSwarm(SwarmSize,ParticleSize,ParticleScope,AdaptFunc)
%功能描述：初始化粒子群，限定粒子群的位置以及速度在指定的范围内
%[ParSwarm,OptSwarm,BadSwarm]=InitSwarm(SwarmSize,ParticleSize,ParticleScope,AdaptFunc)
%
%输入参数：SwarmSize:种群大小的个数
%输入参数：ParticleSize：一个粒子的维数
%输入参数：ParticleScope:一个粒子在运算中各维的范围；
%　　　　　　　　 ParticleScope格式:
%　　　　　　　　　　 3维粒子的ParticleScope格式:
%　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 [x1Min,x1Max
%　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 x2Min,x2Max
%　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 x3Min,x3Max]
%
%输入参数：AdaptFunc：适应度函数
%
%输出：ParSwarm初始化的粒子群
%输出：OptSwarm粒子群当前最优解与全局最优解
%
%用法[ParSwarm,OptSwarm,BadSwarm]=InitSwarm(SwarmSize,ParticleSize,ParticleScope,AdaptFunc);
%
%异常：首先保证该文件在Matlab的搜索路径中，然后查看相关的提示信息。
%
%编制人：XXX
%编制时间：2007.3.26
%参考文献：无
%

%容错控制
if nargin~=4
error('输入的参数个数错误。')
end
if nargout<2
error('输出的参数的个数太少，不能保证以后的运行。');
end

[row,colum]=size(ParticleSize);
if row>1|colum>1
error('输入的粒子的维数错误，是一个1行1列的数据。');
end
[row,colum]=size(ParticleScope);
if row~=ParticleSize|colum~=2
error('输入的粒子的维数范围错误。');
end

%初始化粒子群矩阵

%初始化粒子群矩阵，全部设为[0-1]随机数
%rand('state',0);
ParSwarm=rand(SwarmSize,2*ParticleSize+1);

%对粒子群中位置,速度的范围进行调节
for k=1:ParticleSize
ParSwarm(:,k)=ParSwarm(:,k)*(ParticleScope(k,2)-ParticleScope(k,1))+ParticleScope(k,1);
 %调节速度，使速度与位置的范围一致
ParSwarm(:,ParticleSize+k)=ParSwarm(:,ParticleSize+k)*(ParticleScope(k,2)-ParticleScope(k,1))+ParticleScope(k,1);
end

%对每一个粒子计算其适应度函数的值

for k=1:SwarmSize
ParSwarm(k,2*ParticleSize+1)=AdaptFunc(ParSwarm(k,1:ParticleSize));
end

%初始化粒子群最优解矩阵
OptSwarm=zeros(SwarmSize+1,ParticleSize);
%粒子群最优解矩阵全部设为零
[maxValue,row]=max(ParSwarm(:,2*ParticleSize+1));
%寻找适应度函数值最大的解在矩阵中的位置(行数)
OptSwarm=ParSwarm(1:SwarmSize,1:ParticleSize);
OptSwarm(SwarmSize+1,:)=ParSwarm(row,1:ParticleSize);
