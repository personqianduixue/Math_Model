'''
用一个向量保存各个product_id号码:product_id[x]
通过index = product_id[i]作为索引，
提取出对应的product_id == index的所有元组，组成临时矩阵matrix。
用临时矩阵计算另一个属性的方差：
先提取出那个属性的全部数据成为一个df.Series，求方差.var()
'''

import numpy as np
import pandas as pd
import os
import sys
import codecs
import chardet


# class ProcessData(object)
class ProcessData(object):
    '''
        This class is for data pre-processing.
        Here follows methods description in Chinese.
    '''
    def __init__(self, hair_dryer_path=None, microwave_path=None, pacifier_path=None):
        '''
        :param hair_dryer_path: path of hair_dryer.xlsx
        :param microwave_path: path of microwave.xlsx
        :param pacifier_path: path of pacifier.xlsx
        '''
        # to DataFrame format
        self.hair_dryer = pd.DataFrame(pd.read_excel(hair_dryer_path))
        self.microwave = pd.DataFrame(pd.read_excel(microwave_path))
        self.pacifier = pd.DataFrame(pd.read_excel(pacifier_path))
        # print("len(self.hair_dryer)")
        # print(len(self.hair_dryer))

        # print("self.hair_dryer.iat[1, 2]")
        # print(self.hair_dryer.iat[1, 2])
        return None

    def drop_col(self, str):

        self.hair_dryer = self.hair_dryer.drop([str], axis=1)
        self.microwave = self.microwave.drop([str], axis=1)
        self.pacifier = self.pacifier.drop([str], axis=1)

        return (self.hair_dryer, self.microwave, self.hair_dryer)

    def del_verified_purchase_N(self, hair_dryer_save_path=None,
                                microwave_save_path=None, pacifier_save_path=None):
        '''
        This method deletes tuples whose verified_purchase is 'N',
        which means the customer didn't purchase the product but still made comments.
        :return:self.parameters
        '''
        # pattern: df = df.drop(df[df['three'] == 14].index)
        hair_dryer = self.hair_dryer
        microwave = self.microwave
        pacifier = self.pacifier

        self.hair_dryer = hair_dryer.drop(
            hair_dryer[
                (hair_dryer['verified_purchase'] != 'Y') & (hair_dryer['verified_purchase'] != 'y')
                ].index
        )
        self.microwave = microwave.drop(
            microwave[
                (microwave['verified_purchase'] != 'Y') & (microwave['verified_purchase'] != 'y')
                ].index
        )
        self.pacifier = pacifier.drop(
            pacifier[
                (pacifier['verified_purchase'] != 'Y') & (pacifier['verified_purchase'] != 'y')
                ].index
        )

        return (self.hair_dryer, self.microwave, self.pacifier)

    def del_helpful_votes_total_votes(self):
        '''
                This method deletes tuples whose helpful_votes/total_votes is '' or 0
                :return:None
        '''
        # pattern: df = df.drop(df[df['three'] == 14].index)
        hair_dryer = self.hair_dryer
        microwave = self.microwave
        pacifier = self.pacifier
        # | (hair_dryer['helpful_votes'] != '')

        self.hair_dryer = hair_dryer.drop(
            hair_dryer[
                (hair_dryer['helpful_votes'] == 0) | (hair_dryer['helpful_votes'] == '')
                ].index
        )
        self.microwave = microwave.drop(
            microwave[
                (microwave['helpful_votes'] == 0) | (hair_dryer['helpful_votes'] == '')
                ].index
        )
        self.pacifier = pacifier.drop(
            pacifier[
                (pacifier['helpful_votes'] == 0) | (hair_dryer['helpful_votes'] == '')
                ].index
        )
        return (self.hair_dryer, self.microwave, self.pacifier)

    def transDF(self):

        hair_dryer = self.hair_dryer
        microwave = self.microwave
        pacifier = self.pacifier

        self.hair_dryer = self.hair_dryer.stack()
        self.hair_dryer = self.hair_dryer.unstack(0)
        print("hair_dryer.stack()")
        print(self.hair_dryer)


        return (self.hair_dryer, self.microwave, self.pacifier)

    def mysort(self, str):
        '''
        :param str:sort by str(name of col)
        :return:
        '''
        self.hair_dryer = self.hair_dryer.sort_values(str, ascending=True)
        self.microwave = self.microwave.sort_values(str, ascending=True)
        self.pacifier = self.pacifier.sort_values(str, ascending=True)
        # error!!!!!!
        return (self.hair_dryer, self.microwave, self.pacifier)

    def tranStr2Num(self, col_name=None):
        '''
        This method transform string to number by col
        :return: self.parameters
        '''
        class_mapping = {
            'A': 0, 'B': 1, 'C': 2, 'D': 3, 'E': 4, 'F': 5, 'G': 6,
            'H': 7, 'I': 8, 'J': 9, 'K': 10, 'L': 11, 'M': 12,
            'N': 13, 'O': 14, 'P': 15, 'Q':16, 'R': 17, 'S': 18,
            'T': 19, 'U': 20, 'V': 21, 'W':22, 'X': 23, 'Y': 24, 'Z': 25,
            'a': 26, 'b': 27, 'c': 28, 'd': 29, 'e': 30, 'f': 31,
            'g': 32, 'h': 33, 'i': 34, 'j': 35, 'k': 36, 'l': 37, 'm': 38,
            'n': 39, 'o': 40, 'p': 41, 'q': 42, 'e': 43, 's': 44, 't': 45,
            'u': 46, 'v': 47, 'w': 48, 'x': 49, 'y': 50, 'z': 51
        }
        # data[class] = data[class].map(class_mapping)
        # self.hair_dryer[col_name] = self.hair_dryer[col_name].map(class_mapping)
        self.hair_dryer[col_name]
        return (self.hair_dryer, self.microwave, self.pacifier)

    def cal_var_of_col(self, col_name):
        '''
        :param str: name of col
        :return:
        '''
        hair_dryer = self.hair_dryer[col_name]
        microwave = self.microwave[col_name]
        pacifier = self.pacifier[col_name]

        return (hair_dryer.var(), microwave.var(), pacifier.var())     # return var

    def cal_avg_var_by_product_id(self):
        '''
        This method calculate average var of different product
        :return:
        '''
        path = "./preprocessedData/product_id/pacifier/pid_"
        n1 = 173    # hair_dryer
        n2 = 868    # microwave
        n3 = 403    # pacifier
        save_path = "./preprocessedData/var/var.xlsx"
        product_id = []
        var_list = []
        for i in range(n3):# hair_dryer:173, microwave: 868
            Si = str(i)
            print(Si)
            df = pd.DataFrame(pd.read_excel(path+Si+'.xlsx'))
            print(df['product_id'])
            product_id.append(df.iat[0, 2])     # 保存product_id
            var_list.append(df['star_rating'].var())       # 计算每个product_id的方差
        print("product_id")
        print(product_id)
        print("var_list")
        print(var_list)
        dict = {'product_id': product_id, 'star_var': var_list}
        new = pd.DataFrame(dict, columns=['product_id', 'star_var'])#, columns=['product_id', 'star_var'])
        new.to_excel(save_path, index=False)
        return None

    def select_rows(self):
        '''
        This methods are aiming at searching the 5 and 0 star_rating score,
        and use these rows to construct a matrix
        :return: three matrix
        '''
        hair_dryer = self.hair_dryer
        microwave = self.microwave
        pacifier = self.pacifier

        # create list to append data
        # hair_dryer
        length = len(microwave)
        print(length)
        print(microwave.iat[0, 2])
        self.list = list()
        for i in range(length - 1):
            if pacifier.iat[i + 1, 2] != microwave.iat[i, 2]:
                self.list.append(microwave.iat[i + 1, 2])
        print(self.list)
        # Here we can optimize this algorithm but I have no time to do it.
        save_path = "./preprocessedData/product_id/"
        j = 0
        for x in self.list:
            Sj = str(j)
            # hair_dryer = self.hair_dryer.loc[self.hair_dryer['product_id'] == x]
            # hair_dryer.to_excel(save_path+'hair_dryer/pid_'+Sj+'.xlsx', index=False)
            microwave = self.microwave.loc[self.microwave['product_id'] == x]
            microwave.to_excel(save_path + 'microwave/pid_' + Sj + '.xlsx', index=False)
            # pacifier = self.pacifier.loc[self.pacifier['product_id'] == x]
            # pacifier.to_excel(save_path + 'pacifier/pid_' + Sj + '.xlsx', index=False)
            j += 1

        # hair_dryer = self.hair_dryer.loc[(self.hair_dryer['star_rating'] == 0) | (self.hair_dryer['star_rating'] == 5)]
        # microwave = self.microwave.loc[(self.microwave['star_rating'] == 0) | (self.microwave['star_rating'] == 5)]
        # pacifier = self.pacifier.loc[(self.pacifier['star_rating'] == 0) | (self.pacifier['star_rating'] == 5)]
        #---------------------------------------------------------------------------------------------------------#
        # hair_dryer = self.hair_dryer.loc[(self.hair_dryer['star_rating'] != 0) & (self.hair_dryer['star_rating'] != 5)]
        # microwave = self.microwave.loc[(self.microwave['star_rating'] != 0) & (self.microwave['star_rating'] != 5)]
        # pacifier = self.pacifier.loc[(self.pacifier['star_rating'] != 0) & (self.pacifier['star_rating'] != 5)]

        len1 = [len(hair_dryer), len(microwave), len(pacifier)]
        return (hair_dryer, microwave, pacifier, len1)

    def save_to_excel(self, save_path=None):
        '''
        :param save_path: a vector with path of self.hair_dryer, self.microwave, self.pacifier
        :return:self.parameters
        '''
        # save to excel
        self.hair_dryer.to_excel(save_path[0])
        self.microwave.to_excel(save_path[1])
        self.pacifier.to_excel(save_path[2])
        return (self.hair_dryer, self.microwave, self.pacifier)

    def get_class_by_col(self, col_name):
        '''
        This method can recognize how many statistic are the same in a col,
        and merge the rows with the same statistic in the certain col.
        :param col_name:
        :return:
        '''
        hair_dryer = self.hair_dryer
        microwave = self.microwave
        pacifier = self.pacifier

        self.hair_dryer.groupby(col_name).apply(list)


        # hair_dryer = hair_dryer.set_index(
        #     [col_name, hair_dryer.groupby(col_name).cumcount() + 1]
        # ).unstack().sort_index(level=1, axis=1)
        # self.hair_dryer.columns = self.hair_dryer.columns.map('{0[0]}_{0[1]}'.format())
        # self.hair_dryer.reset_index()

        # microwave = microwave.set_index(
        #     [col_name, microwave.groupby(col_name).cumcount() + 1]
        # ).unstack().sort_index(level=1, axis=1)
        # pacifier = pacifier.set_index(
        #     [col_name, pacifier.groupby(col_name).cumcount() + 1]
        # ).unstack().sort_index(level=1, axis=1)

        hair_dryer_save_path = "./preprocessedData/transformedData/hair_dryer_" + col_name + ".xlsx"
        microwave_save_path = "./preprocessedData/transformedData/microwave_" + col_name + ".xlsx"
        pacifier_save_path = "./preprocessedData/transformedData/pacifier_" + col_name + ".xlsx"
        save_path = [hair_dryer_save_path, microwave_save_path, pacifier_save_path]

        self.save_to_excel(save_path=save_path)

        # hair_dryer = hair_dryer[col_name]
        # microwave = microwave[col_name]
        # pacifier = pacifier[col_name]

        return (self.hair_dryer, self.microwave, self.pacifier)

    def get_parameters(self):
        return (self.hair_dryer, self.microwave, self.pacifier)

    def new_col(self, new_col_name=None):
        '''
        create a new col
        :param new_col_name: name of new col
        :return:
        '''
        self.hair_dryer[new_col_name] = None
        self.microwave[new_col_name] = None
        self.pacifier[new_col_name] = None
        return (self.hair_dryer, self.microwave, self.pacifier)

    def count_mean_char_num(self, hair_dryer, microwave, pacifier, len1=0):

        hd = hair_dryer['review_body']
        mc = microwave['review_body']
        pf = pacifier['review_body']

        hair_dryer['num'] = None
        microwave['num'] = None
        pacifier['num'] = None

        hair_dryer['num'] = hair_dryer['review_body'].str.len()
        microwave['num'] = microwave['review_body'].str.len()
        pacifier['num'] = pacifier['review_body'].str.len()
        print("pacifier['review_body'].str.len()")
        print(pacifier['review_body'].str.len())
        print("pacifier['num']")
        print(pacifier['num'])
        str = "./preprocessedData/we.xlsx"
        # pacifier.to_excel(str)
        print("12138")
        print(pacifier)
        print("pacifier.iat[1, 11]")
        print(pacifier.iat[22, 11])
        # pacifier : clear blank data manually.

        # hair_dryer
        N = len(pacifier)
        print("N:", N)
        S_len = 0
        for i in range(N):
            S_len += pacifier.iat[i, 11]
        print("S_len:", S_len)
        Mean_len = S_len / N

        print("length")
        print(S_len)
        print("Mean len")
        print(Mean_len)



        # vec = [hair_dryer, microwave, pacifier]
        # # hair_dryer
        # N = [len(hair_dryer), len(microwave), len(pacifier)]
        # S_len = [0, 0, 0]
        # Mean_len = [0, 0, 0]
        # for i in range(3):
        #     for j in range(N[0]):
        #         # S_len[i] += hair_dryer.iat[j, 11]
        #         S_len[i] += vec[i].iat[j, 11]
        #     Mean_len[i] = S_len[i] / N[0]

        print("121234")
        print(hair_dryer['num'])

        # # % time
        # # test['contentLen2'] = test['content'].str.len()
        # print("print")
        # print(hair_dryer['review_body'].str.len())

        return None
# class ProcessData(object)


# preprocessing()
def preprocessing(hair_dryer_path=None, microwave_path=None, pacifier_path=None):
    '''
    :param hair_dryer_path: file_path of hairdryer.xlsx
    :param microwave_path: file_path of microwave.xlsx
    :param pacifier_path: file_path of pacifier.xlsx
    :return:Instance of the Class named ProcessData
    '''
    pre = ProcessData(hair_dryer_path=hair_dryer_path,
                     microwave_path=microwave_path, pacifier_path=pacifier_path)

    pre.drop_col('marketplace')  # delete marketplace
    pre.drop_col('product_category')

    pre.del_helpful_votes_total_votes()

    hair_dryer_save_path = "./output_dataset/hair_dryer.xlsx"
    microwave_save_path = "./output_dataset/microwave.xlsx"
    pacifier_save_path = "./output_dataset/pacifier.xlsx"

    pre.del_verified_purchase_N(
        hair_dryer_save_path=hair_dryer_save_path,
        microwave_save_path=microwave_save_path,
        pacifier_save_path=pacifier_save_path
    )
    pre.drop_col('verified_purchase')
    pre.drop_col('vine')

    # print(pre.hair_dryer)

    # save to excel
    pre.hair_dryer.to_excel(hair_dryer_save_path)
    pre.microwave.to_excel(microwave_save_path)
    pre.pacifier.to_excel(pacifier_save_path)

    return pre
# preprocessing()


def problemC_2d(hair_dryer_path=None, microwave_path=None, pacifier_path=None):
    '''
    :param hair_dryer_path: file_path of hairdryer.xlsx
    :param microwave_path: file_path of microwave.xlsx
    :param pacifier_path: file_path of pacifier.xlsx
    :return:Instance of the Class named ProcessData
    '''
    # ProCess_Data
    # import Preprocessed Data
    pcd = ProcessData(hair_dryer_path=hair_dryer_path,
                      microwave_path=microwave_path, pacifier_path=pacifier_path)

    hair_dryer_save_path = "./preprocessedData/sortedData/hair_dryer.xlsx"
    microwave_save_path = "./preprocessedData/sortedData/microwave.xlsx"
    pacifier_save_path = "./preprocessedData/sortedData/pacifier.xlsx"

    save_path = [hair_dryer_save_path, microwave_save_path, pacifier_save_path]

    # (hair_dryer, microwave, pacifier) = pcd.tranStr2Num('product_id')

    # We delete some dirty data manually before mysort().
    (hair_dryer, microwave, pacifier) = pcd.mysort(str='product_id')

    # calculating var of the whole statistic
    # hair_dryer_var, microwave_var, pacifier_var = pcd.cal_var_of_col('star_rating')
    # print("var of hair_dryer is ", hair_dryer_var)
    # print("var of microwave is ", microwave_var)
    # print("var of pacifier is ", pacifier_var)

    # (hair_dryer, microwave, pacifier, len1) = pcd.select_rows()
    pcd.cal_avg_var_by_product_id()
    # (hair_dryer_mean_num, microwave_mean_num, pacifier_mean_num) =\
    # pcd.count_mean_char_num(
    #         hair_dryer=hair_dryer, microwave=microwave, pacifier=pacifier, len1=len1
    # )

    # pcd.get_class_by_col('product_id')

    # pcd.save_to_excel(save_path=save_path)

    return pcd

def problemC_2b(hair_dryer_path=None, microwave_path=None, pacifier_path=None):
    pcd = ProcessData(hair_dryer_path=hair_dryer_path,
                      microwave_path=microwave_path, pacifier_path=pacifier_path)

    hair_dryer_save_path = "./preprocessedData/sortedData/hair_dryer.xlsx"
    microwave_save_path = "./preprocessedData/sortedData/microwave.xlsx"
    pacifier_save_path = "./preprocessedData/sortedData/pacifier.xlsx"

    save_path = [hair_dryer_save_path, microwave_save_path, pacifier_save_path]

    s_dataset = "./dataset/s_dataset/s"
    to_data_train = "./data/train/s"
    to_data_test = "./data/test/s"
    print("start")
    for i in range(5):      # 文件夹中
        Si = str(i+1)
        df = pd.DataFrame(pd.read_excel(s_dataset + Si + '.xlsx'))
        # df = df['review_body']
        for j in range(len(df)):    # 文件内
            print("(i: ", i, "j: ", j, ")")
            Sj = str(j+1)
            train_path = to_data_train + Si + '/s' + Sj + '.txt'
            test_path = to_data_test + Si + '/s' + Sj + '.txt'
            f1 = open(train_path, 'w', encoding='unicode')  # 写入train
            # f1 = codecs.open(train_path,)
            print(df.iat[j, 10], file=f1)
            f1.close()
            f2 = open(test_path, 'w', encoding='unicode')  # 写入test
            print(df.iat[j, 10], file=f2)
            f2.close()

            # f = codecs.open(file, 'r', in_enc)
            # new_content = f.read()
            # codecs.open(file, 'w', out_enc).write(new_content)
            # Sj = str(j)
            # df_ = df.iat[j, 0]
            # df_.to_csv(to_data_test + Sj + '.xlsx')
            # df_.to_csv(to_data_train + Sj + '.xlsx')


    return None


# __main__
if __name__ == "__main__":
    print("main.start...")

    '''
    pre-processing modules
    '''
    # hair_dryer_path = "./dataset/hair_dryer.xlsx"
    # microwave_path = "./dataset/microwave.xlsx"
    # pacifier_path = "./dataset/pacifier.xlsx"

    # preprocessing(hair_dryer_path=hair_dryer_path,
    #      microwave_path=microwave_path, pacifier_path=pacifier_path)

    # We needs to modify/delete col 0 in these excel files manually
    hair_dryer_path = "./preprocessedData/hair_dryer.xlsx"
    microwave_path = "./preprocessedData/microwave.xlsx"
    pacifier_path = "./preprocessedData/pacifier.xlsx"

    # save_path = [hair_dryer_path, microwave_path, pacifier_path]

    # problemC_2d(hair_dryer_path=hair_dryer_path,
    #             microwave_path=microwave_path, pacifier_path=pacifier_path)
    problemC_2b(hair_dryer_path=hair_dryer_path,
                microwave_path=microwave_path, pacifier_path=pacifier_path)

    print("main.end...")
# __main__
