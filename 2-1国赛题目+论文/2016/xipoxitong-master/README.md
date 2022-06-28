# 系泊系统的优化设计
## 问题背景

此问题是2016年中国全国大学生数学建模竞赛赛题，赛题可以在
<http://www.mcm.edu.cn/html_cn/block/8579f5fce999cdc896f78bca5d4f8237.html>
下载查看，也可以查看`xipoxitong\文章\xipoxitong.pdf`文件。

## 模型说明

共设计3个系泊系统的模拟模型：

1.在平面直角坐标系下对系泊系统进行模拟，求解不同条件下的系泊系统的状态
，并在此系统上，设计优化模型，求解最优的重物球质量。

2.在上面的2D模型下，增加考虑力矩平衡，并对锚链进行悬链线分析，构建了改进的
悬链线模型。

3.在空间直角坐标系下对系泊系统进行模拟，即所谓的3D模型。

## 文件说明
### 2D系泊系统

`For2D.m`:此函数用于给定x0和y_0后求解系泊系统的状态曲线。<br>

`bestpoint.m ` :离散枚举法求最优吃水深度h。<br>

`bestpoint2.m` :迭代算法求最优吃水深度h。<br>

`bestpoint3.m` :fzero法法求最优吃水深度h。<br>

`best_xitong.m`:求系统信息及系统图形。<br>

`solve2.m`:求解第二问。绘制m_qiu和y0、x0、alpha1、alpha2之间的关系图；并用`IENSGAii算法` 求解最优m_qiu，使得h、![](http://latex.codecogs.com/png.latex?$\textstyle\pi*x_0^2$)和alpha1最小，且alpha1和alpha2在范围内。<br>

`multi_GA_m.m` :`solve2.m`调用的子文件，是`IENSGAii算法`的多目标规划的目标函数。<br>

`solve3.m` :求解第三问。使用 GA 和 fmincon 两种方法来求解这个非线性约束优化模型。<br>

`GA_m_l.m ` : `solve3.m`调用的子文件，问题3要求解的优化模型的目标。<br>

`circlecon_m_l.m ` : `solve3.m`调用的子文件，问题3的非线性约束设置。<br>

`effect_v_wind.m ` : 查看风速对系统状态的影响。

### 2D模型改进

`For2D_expand.m` :此函数是系泊系统的3元方程组的目标函数，用于fsolve函数。模型改进：引入"力矩平衡"和"悬链线方程"。<br>

`bestpoint3_expand.m` : 此函数用于求解系泊系统的3元方程组，从而求出最优y0,x0,alpha2。<br>

`best_xitong_expand.m`：利用bestpoint3_expand计算bestx0, besty0情况下的系统信息及系统图形。<br>

`solve3_expand.m`：此文件用于求解第三问，最优m_qiu、L和I使单一目标最小。<br>

`GA_m_l_expand.m`：`solve3_expand.m`调用的子函数，是第三问优化问题的`GA算法`的目标函数。<br>

`circlecon_m_l_expand.m`：`solve3_expand.m`调用的子函数，是第三问优化问题的`GA算法`的约束条件。<br>

`effect_v1_v2_H.m`：风速v1、水速v2和水深H对系统状态的影响。

### 3D系泊系统

>`For3D.m`：此函数用于给定x0、y0和z0后求解3D系泊系统的状态曲线。
>>`D3fun_fubiao.m`：`For3D.m`调用的子函数，用于对浮标进行受力分析。
>>`D3fun_gangguan.m`：`For3D.m`调用的子函数，用于对钢管进行受力分析。
>>`D3fun_gangtong.m`：`For3D.m`调用的子函数，用于对钢桶进行受力分析。
>>`D3fun_maolian.m`：`For3D.m`调用的子函数，用于对锚链进行受力分析。<br>

`bestpoint_3D.m`：用离散枚举法法求最优吃水深度h。<br>

`bestpoint1_3D.m`：用fzero法求最优吃水深度h。<br>

`best_xitong_3D.m`：计算bestx0, besty0，bestz0情况下的系统信息及系统3D图形。


