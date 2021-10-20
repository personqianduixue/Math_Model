import numpy as np
import pandas as pd


class pandasDataFrame(object):
    def __init__(self):
        self.df = pd.DataFrame(
            np.arange(16).reshape(4, 4),
            index=['Ohio', 'Colorado', 'Utah', 'New York'],
            columns=['one', 'two', 'three', 'fou r']
        )
        return None

    def showDFbyName(self, index=None, col=None):
        df = self.df
        # 与and 或or 非not
        if index is None and col is None:
            print(df)
            return df
        elif index is not None and col is None:
            print("index is not None and col is None")
            # print(df.ix[index])
            print(df.loc[index])
            return df.loc[index]
        elif index is None and col is not None:
            # print(self.df.two)#这种做法很局限，比如'two three'这种有空格的，就会报错
            print(df[col])  # 根据列的描述查找整个列
            return df[col]
        elif index is not None and col is not None:
            # print(df[index][col])
            pass

        return None


if __name__ == "__main__":
    dframe = pandasDataFrame()
    # df = pandasDataFrame()
    # # df = df.drop(df[df['three'] == 14].index)
    # # print(df)
    # # df.showDFbyName(col=['one', 'two', 'three', 'fou r'])
    # df.showDFbyName(index=['Colorado', 'New York'])
    df = pd.DataFrame(
        data=[
            ['lisa', 'f', 22],
            ['joy', 'f', 22],
            ['tom', 'm', '21']],
        index=[1, 2, 3],
        columns=['name', 'sex', 'age']
    )
    print(df)
    df['school'] = None
    df.iat[1, 3] = 15
    df.iat[2, 3] = 'str'
    df.iat[0, 3] = dframe
    print("df.loc[2]")
    print(df.iloc[2])
    df_ = df.iloc[2]
    str = "./ICM_MCM_2020.Y.txt"
    print(df.iat[1, 2])
    f = open(str, 'w')
    print(df.iat[0, 0], file=f)
    f.close()


    print("df.loc[2]")
    print(df)
    df.to_excel("./TSP_GA/KK.xlsx")
