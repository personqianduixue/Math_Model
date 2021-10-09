import os
import pandas as pd


# 分页显示数据, 设置为 False 不允许分页
pd.set_option('display.expand_frame_repr', False)

# 最多显示的列数, 设置为 None 显示全部列
pd.set_option('display.max_columns', None)

# 最多显示的行数, 设置为 None 显示全部行
pd.set_option('display.max_rows', None)

# 对齐中文文本
pd.set_option('display.unicode.ambiguous_as_wide', True)
pd.set_option('display.unicode.east_asian_width', True)

R = pd.read_excel("../table/数据预处理表.xlsx", index_col=0, sheet_name=3).fillna(0)


def main(path, file):
    all_produce = pd.DataFrame(0, index=R.index, columns=R.columns)  # 总加工零件数量
    ex_color = []
    ex_produce = []
    for i in range(8):
        table = pd.read_excel(path + file, sheet_name=i)
        ex_color.append(table.isna().sum()[0])
        ex_produce.append(table['零件'].tolist())
        for j in table.index:
            if table.at[j, "数量"] > 0:
                all_produce.at[table.at[j, "零件"], table.at[j, "颜色"]] += table.at[j, "数量"]
    print("\n* 分析项目1: 换色次数")
    print(f"平均换色次数: {sum(ex_color) / 8} ({ex_color})")
    print("\n* 分析项目2: 换支架次数")
    different = 0
    for k in range(7):
        for m in range(303):
            if ex_produce[k][m] != ex_produce[k + 1][m]:
                different += 1
    print(different / 8)
    print("\n* 分析项目3: 完成度矩阵")
    print(all_produce)
    print("\n* 分析项目4: 任务完成情况")
    print(f"总零件任务完成情况:  {31 * 10 -(R == 0).sum().sum()-(all_produce < R).sum().sum()}/{31 * 10 -(R == 0).sum().sum()}")
    print("\n* 分析项目5: 加工零件数量完成情况")
    print(f"总零件生产量完成情况:  {R.sum().sum() + (all_produce - R)[(all_produce - R) <= 0].sum().sum()}/{R.sum().sum()}")


if __name__ == '__main__':
    files = [file for file in os.listdir("../table") if file.endswith(".xlsx")]
    print("./table 目录下有下列文件")
    for index, file in enumerate(files):
        print(index + 1, file)
    try:
        main("../table/", files[int(input("* 请输入文件编号, 进行描述性分析: ")) - 1])
    except:
        print("不支持的文件类型")
