# 导入数据
import pandas as pd
import numpy as np
import pdb

table1 = pd.read_excel("../table/C题附件.xlsx", index_col=[0, 1], sheet_name=0)
table2 = pd.read_excel("../table/C题附件.xlsx", index_col=0, sheet_name=2)

# 获取需求量对应支架数量
produce2color = table1.copy()
produce2color['所需滑橇数量'] = np.ceil(produce2color['需求量'] / 6)       # ceil 向上除法

# 合并支架数量
for index in produce2color.index:
    produce2color.at[index, '支架数量'] = table2.at[index[0], '支架数量']
produce2color = produce2color.astype(int)   # 取整

# 创建反向映射表
color2produce_index_level1 = []
color2produce_index_level2 = []
for index in produce2color.index:
    color2produce_index_level1.append(index[1])
    color2produce_index_level2.append(index[0])

color2produce_index_level = sorted(list(zip(color2produce_index_level1, color2produce_index_level2)))   # 按照颜色组合排序
color2produce = pd.DataFrame(index=[[index[0] for index in color2produce_index_level], [index[1] for index in color2produce_index_level]])

# 填充反向映射表顺序
for index in produce2color.index:
    color2produce.at[(index[1], index[0]), '需求量'] = produce2color.at[index, '需求量']
    color2produce.at[(index[1], index[0]), '所需滑橇数量'] = produce2color.at[index, '所需滑橇数量']
    color2produce.at[(index[1], index[0]), '至少需要圈数'] = np.ceil(produce2color.at[index, '需求量'] / produce2color.at[index, '支架数量'])
    color2produce.at[(index[1], index[0]), '支架数量'] = produce2color.at[index, '支架数量']

pdb.set_trace()
# 创建规格矩阵
color_produce_type_matrix = pd.DataFrame(index=sorted(table1.index.levels[0]), columns=['支架数量'])
color_produce_require_matrix = pd.DataFrame(index=sorted(table1.index.levels[0]), columns=sorted(table1.index.levels[1], key=lambda item: item[::-1]))
for index in color2produce_index_level:
    color_produce_type_matrix.at[index[1], '支架数量'] = produce2color.at[(index[1], index[0]), '支架数量']
    color_produce_require_matrix.at[index[1], index[0]] = produce2color.at[(index[1], index[0]), '需求量']

# 导出数据
Excel_Writer = pd.ExcelWriter("../table/数据预处理表.xlsx")
color2produce.to_excel(Excel_Writer, '颜色-产品需求表')
produce2color.to_excel(Excel_Writer, '产品-颜色需求表')
color_produce_type_matrix.to_excel(Excel_Writer, '颜色-产品规格矩阵')
color_produce_require_matrix.to_excel(Excel_Writer, '颜色-产品需求矩阵')
Excel_Writer.save()
