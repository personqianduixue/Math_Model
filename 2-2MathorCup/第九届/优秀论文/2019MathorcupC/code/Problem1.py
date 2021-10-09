import time
import pandas as pd
import gurobipy
from gurobipy import quicksum as sum


def get_time():
    return time.strftime('%Y-%m-%d %H:%M:%S')


# 导入数据
color2produce = pd.read_excel("../table/数据预处理表.xlsx", index_col=[0, 1], sheet_name=0)
produce2color = pd.read_excel("../table/数据预处理表.xlsx", index_col=[0, 1], sheet_name=1)
D = pd.read_excel("../table/数据预处理表.xlsx", index_col=0, sheet_name=2)
R = pd.read_excel("../table/数据预处理表.xlsx", index_col=0, sheet_name=3).fillna(0)

# 创建求解器
MODEL = gurobipy.Model()
print(get_time(), "求解器设置完成...")

# 创建变量
I = range(1, 32)
J = range(1, 11)
K = range(1, 304)
N = range(1, 9)
I1 = {22}
I2 = {23}
I3 = {11, 21, 24, 26}
I4 = {27, 28, 29, 30, 31}
x = MODEL.addVars(I, J, K, N, vtype=gurobipy.GRB.BINARY, name="x")
y = MODEL.addVars(I, J, vtype=gurobipy.GRB.BINARY, name='y')
X = MODEL.addVars(I, J, N, ub=400, vtype=gurobipy.GRB.INTEGER, name="X")
X_ = MODEL.addVars(I, J, ub=400, vtype=gurobipy.GRB.INTEGER, name="X_")
print(get_time(), "变量创建完成...")

# 更新变量环境
MODEL.update()

# 创建目标函数
MODEL.setObjectiveN(-sum(R.iat[i - 1, j - 1] * y[i, j] for i in I for j in J), priority=1, index=0)
MODEL.setObjectiveN(-sum(X_[i, j] for i in I for j in J), priority=0, index=1)
print(get_time(), "目标函数设置完成...")

# 创建约束条件
MODEL.addConstrs(sum(x[i, j, k, n] for i in I for j in J) <= 1 for k in K for n in N)
print(get_time(), "约束 1: 变量不冲突约束, 创建完成...")

MODEL.addConstrs(X[i, j, n] <= 6 * sum(x[i, j, k, n] for k in K) for i in I for j in J for n in N)
MODEL.addConstrs(X[i, j, n] >= 6 * (sum(x[i, j, k, n] for k in K) - 1) + 1 for i in I for j in J for n in N)
print(get_time(), "约束 2: 决策变量与零件-颜色总产出量关系, 创建完成...")

MODEL.addConstrs(sum(X[i, j, n] for j in J) <= D.iat[i - 1, 0] for i in I for n in N)   # 支架个数约束零件产出个数
print(get_time(), "约束 3: 支架个数约束零件产出个数约束, 创建完成...")

MODEL.addConstrs(sum(X[i, j, n] for n in N) >= R.iat[i - 1, j - 1] * y[i, j] for i in I for j in J)
MODEL.addConstrs(sum(X[i, j, n] for n in N) <= R.iat[i - 1, j - 1] * (1 + y[i, j]) for i in I for j in J)
print(get_time(), "约束 4: 满足加工需求, 创建完成...")

MODEL.addConstrs(sum(x[i1, j1, k, n] for i1 in I) + sum(x[i2, j2, k + 1, n] for i2 in I for j2 in J if j1 != j2) <= 1 for j1 in J for k in K[: -1] for n in N)
MODEL.addConstrs(sum(x[i1, j1, k, n] for i1 in I for j1 in J) + sum(x[i2, j2, k + 1, n] for i2 in I for j2 in J) >= 1 for k in K[: -1] for n in N)
print(get_time(), "约束 5: 颜色排布约束I 不同颜色之间需要摆放过渡支架、不能连续摆放过渡支架, 创建完成...")

MODEL.addConstrs(sum(x[i1, j1, k + 2, n] for i1 in I) + sum(x[i2, j2, k, n] for i2 in I) <= 1 for j1 in [1, 2] for j2 in [3, 4, 5, 6] for k in K[: -2] for n in N)
print(get_time(), "约束 6: 颜色排布约束II 任意红色和任意蓝色后面不能安排任意白色, 创建完成...")

MODEL.addConstrs(sum(x[i1, j1, k + 2, n] for i1 in I) + sum(x[i2, j2, k, n] for i2 in I) <= 1 for j1 in [9, 10] for j2 in [1] for k in K[: -2] for n in N)
print(get_time(), "约束 7: 颜色排布约束II 极地白色后面不能安排任意黑色, 创建完成...")

MODEL.addConstrs(sum(x[i1, 2, k + 2, n] for i1 in I) <= sum(x[i2, 2, k + 1, n] + x[i2, 1, k, n] for i2 in I) for k in K[: -2] for n in N)
print(get_time(), "约束 8: 颜色排布约束II 钻石白色前面必须安排极地白色或钻石白色, 创建完成...")

MODEL.addConstrs(2 * (1 - sum(x[i1, j, k, n] for i1 in I1 for j in J)) >= sum(x[i2, j, k + 1, n] + x[i2, j, k - 1, n] for i2 in (I2 | I3) for j in J) for k in K[1: -1] for n in N)
MODEL.addConstrs(2 * (1 - sum(x[i1, j, k, n] for i1 in I2 for j in J)) >= sum(x[i2, j, k + 1, n] + x[i2, j, k - 1, n] for i2 in (I1 | I3) for j in J) for k in K[1: -1] for n in N)
MODEL.addConstrs(2 * (1 - sum(x[i1, j, k, n] for i1 in I3 for j in J)) >= sum(x[i2, j, k + 1, n] + x[i2, j, k - 1, n] for i2 in (I1 | I2) for j in J) for k in K[1: -1] for n in N)
print(get_time(), "约束 9: I1, I2, I3不同项目零件不能相邻放置, 创建完成...")

MODEL.addConstrs(2 * (1 - sum(x[i1, j, k, n] for i1 in I1 | I2 for j in J)) >= sum(x[i2, j, k + 1, n] + x[i2, j, k - 1, n] for i2 in I4 for j in J) for k in K[1: -1] for n in N)
print(get_time(), "约束 10: I1 ∪ I2 不能与 I4 相邻排布, 创建完成...")

MODEL.addConstrs(X_[i, j] <= sum(X[i, j, n] for n in N) for i in I for j in J)
MODEL.addConstrs(X_[i, j] <= R.iat[i - 1, j - 1] for i in I for j in J)
print(get_time(), "约束 11: 有效加工零件数, 创建完成...")

# 执行最优化
MODEL.Params.TimeLimit = 3000    # 限制求解时间
MODEL.optimize()
print(f"生产任务完成度: {sum(y[i, j] for i in I for j in J).getValue()}/{310 - (R == 0).sum().sum()}")
print(f"总零件生产量完成情况: {R.sum().sum() - sum((1 - y[i, j]) * (R.iat[i - 1, j - 1] - sum(X[i, j, n] for n in N)) for i in I for j in J).getValue()}/{R.sum().sum()}")
print(get_time(), "模型求解完成, 正在导出结果...")

# 输出模型结果
Excel_Writer = pd.ExcelWriter("../table/问题一模型求解.xlsx")

for n in N:
    result = pd.DataFrame(index=K, columns=['零件', '颜色', '数量'])
    for i in I:
        for j in J:
            x_num = X[i, j, n].X_  # 26
            for k in K:
                if x[i, j, k, n].X:
                    result.at[k, '零件'] = R.index[i - 1]
                    result.at[k, '颜色'] = R.columns[j - 1]
                    result.at[k, "数量"] = 6 if x_num > 6 else x_num
                    x_num -= 6
    result.to_excel(Excel_Writer, f"第 {n} 圈")

Excel_Writer.save()
print(get_time(), "完成...")
