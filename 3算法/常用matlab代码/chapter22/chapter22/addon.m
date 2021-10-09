%% Matlab神经网络43个案例分析

% 单层竞争神经网络的数据分类—患者癌症发病预测
% by 王小川(@王小川_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003

%% SOM结构函数

%% plotsom(pos)

%% 结构
% 网格层结构函数
pos = gridtop(2,3)

pos = gridtop(3,2)

pos = gridtop(8,10);


% 六角结构函数
pos = hextop(2,3)

pos = hextop(8,10);

% 随机层结构函数
pos = randtop(2,3)

pos = randtop(8,10);

%% 距 离
% boxdist()

% Box距离。在给定神经网络某层神经元的位置后，可以利用该函数计算神经元之间的距离。该函数通常用于结构函数的gridtop的神经网络层。
pos=gridtop(2,2)
plotsom(pos)
boxdist(pos)

% dist 欧式距离函数
dist(pos)

% linkdist 距离 连接距离函数。
linkdist(pos)

% mandist 距离 Manhattan距离权函数
mandist(pos) 
