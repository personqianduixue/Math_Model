'''
    数据处理方法:
    1.删除marketplace列和product_category列
    2.删除helpful_votes中空白和值为 0的元组
    3.删除verified_purchase为'N'，即未成功支付购买产品的元组，保存副本
    在处理完1. 2. 3.之后：
    customer_id	review_id	product_id	product_parent	product_title	star_rating	helpful_votes	total_votes	vine	review_headline	review_body	review_date
    9192	52341238	R3JXUFI2IMG5H5	B006BNFXHU	591023894	mangroomer 1680xl-6 professional ionic hair dryer for men	5	9	10	Y	Not just a lot of hot air	Confession time: I am not a man. I don't even KNOW a man who uses a hairdryer, so I don't know why this is for Men. That being said, this is the best hairdryer I have ever used. Don't ask me to explain what that Ionic setting does---the manufacturer doesn't even explain it to my satisfaction. But, somehow, it DOES WORK on my cobweb-fine, delicate, difficult, body-less, totally straight, almost-waist-length hair. I wear it long and braided so I can ignore it as much as possible, and so it doesn't fly around all the time and get tangled in stuff or end up in people's food.  I only wash it once a week because it's so darn dry---it would probably all fall out if I washed it every day. I don't perm, color, or otherwise mess with it because chemicals just destroy it. I've had the split ends of my braid knot up so badly in the wind that I've had to cut an inch or more off. Most hairdryers are really hard on my hair, so I use them as little as possible.<br /><br />I like the design of this hairdryer---it's fairly light, comfortable to hold, and the attachment nozzle is nice for focusing the air where I want it. There's nowhere my hair can fly into the works and get tangled. I use the ionic setting with the heat on high, and control the amount of hot air with the handy cool burst blue button that turns the heat off. My hair dries faster and untangles easier than it ever has in my life. Not only that, but it STAYS untangled all week. How is this possible? I don't know. I DON'T CARE!<br /><br />I thought maybe I was imagining all this, so I asked my daughter-in-law to try it. She said, That was the best experience I've ever had with any hairdryer in my whole life.<br /><br />Please don't comment that this can't possibly work and it's all unscientific and that I'm making stuff up, as someone has on one of my other reviews. For me, this hairdryer makes a positive difference (pun intended) on my hair. Now I'm going to buy one for my daughter-in-law!	4/5/2012
    只有这个的vine值是'Y'，所以我干脆也把vine这列删除了。
    数据排序：
    首先按照customer_id排序，然后在基于原有排序的情况中根据product_id排序，
    然后根据star_rating排序

'''

import numpy as np
import pandas as pd


# class preProcess
class preProcess(object):
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
        # self.hair_dryer = pd.read_excel(hair_dryer_path)
        # self.microwave = pd.read_excel(microwave_path)
        # self.pacifier = pd.read_excel(pacifier_path)
        return None

    def drop_col(self, str):
        # mydata = mydata.drop(['', ''], axis=1)
        self.hair_dryer = self.hair_dryer.drop([str], axis=1)
        self.microwave = self.microwave.drop([str], axis=1)
        self.pacifier = self.pacifier.drop([str], axis=1)
        # print("self.hair_dryer")
        # print(self.hair_dryer)
        return (self.hair_dryer, self.microwave, self.hair_dryer)

    def del_verified_purchase_N(self, hair_dryer_save_path=None,
                                microwave_save_path=None, pacifier_save_path=None):
        '''
        This method deletes tuples whose verified_purchase is 'N',
        which means the customer didn't purchase the product but still made comments.
        :return:None
        '''
        # pattern: df = df.drop(df[df['three'] == 14].index)
        hair_dryer = self.hair_dryer
        microwave = self.microwave
        pacifier = self.pacifier

        # df['thing'] = df['thing'].str.upper()

        # delete if verified_purchase is 'N'.
        # hair_dryer = hair_dryer.drop(hair_dryer[hair_dryer['verified_purchase'] == 'N'].index)
        # microwave = microwave.drop(microwave[microwave['verified_purchase'] == 'N'].index)
        # pacifier = pacifier.drop(pacifier[pacifier['verified_purchase'] == 'N'].index)

        self.hair_dryer = hair_dryer.drop(
            hair_dryer[
                (hair_dryer['verified_purchase'] != 'Y') & (hair_dryer['verified_purchase'] != 'y') # 未付款
                & (hair_dryer['vine'] == 'N')   # 无会员
            ].index
        )
        self.microwave = microwave.drop(
            microwave[
                (microwave['verified_purchase'] != 'Y') & (microwave['verified_purchase'] != 'y')
                & (hair_dryer['vine'] == 'N')
            ].index
        )
        self.pacifier = pacifier.drop(
            pacifier[
                (pacifier['verified_purchase'] != 'Y') & (pacifier['verified_purchase'] != 'y')
                & (hair_dryer['vine'] == 'N')
            ].index
        )

        # save to excel
        # self.hair_dryer.to_excel(hair_dryer_save_path)
        # self.microwave.to_excel(microwave_save_path)
        # self.pacifier.to_excel(pacifier_save_path)
        return (self.hair_dryer, self.microwave, self.pacifier)

    def delete_error_data(self, sub_str):
        '''
        This method delete the wrong product info mixed in clear data.
        :return:
        '''
        self.hair_dryer = self.hair_dryer.drop(
            self.hair_dryer[
                ~self.hair_dryer['product_title'].str.contains('hair dryer')
                ].index
        )
        self.microwave = self.microwave.drop(
            self.microwave[
                (~self.microwave['product_title'].str.contains('microwave'))
            ].index
        )
        self.pacifier = self.pacifier.drop(
            self.pacifier[
                (# 且  不包含  近义词
                        (~self.pacifier['product_title'].str.contains('pacifier'))
                    & (~self.pacifier['product_title'].str.contains('nipple'))
                )# 或  包 含  同类不同种
                | (self.pacifier['product_title'].str.contains('nipple sponge brush'))
            ].index
        )

        return None

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

    def mysort(self, str=None):
        self.hair_dryer = self.hair_dryer.sort_values(str, ascending=True)
        self.microwave = self.microwave.sort_values(str, ascending=True)
        self.pacifier = self.pacifier.sort_values(str, ascending=True)
        return (self.hair_dryer, self.microwave, self.pacifier)
# class preProcess


def test(hair_dryer_path=None, microwave_path=None, pacifier_path=None):
    pre = preProcess(hair_dryer_path=hair_dryer_path,
                     microwave_path=microwave_path, pacifier_path=pacifier_path)
    # print(pre.hair_dryer)
    # pre.drop_col('marketplace')     # delete marketplace
    # pre.drop_col('product_category')
    # print("pre.hair_dryer.test")
    # pre.del_helpful_votes_total_votes()
    # print("pre.hair_dryer.test")
    # print(pre.hair_dryer)
    hair_dryer_save_path = "./test_dataset/final_test/hair_dryer.xlsx"
    microwave_save_path = "./test_dataset/final_test/microwave.xlsx"
    pacifier_save_path = "./test_dataset/final_test/pacifier.xlsx"
    # print("123")
    # pre.del_verified_purchase_N(
    #     hair_dryer_save_path=hair_dryer_save_path,
    #     microwave_save_path=microwave_save_path,
    #     pacifier_save_path=pacifier_save_path
    # )
    # pre.drop_col('verified_purchase')
    # pre.drop_col('vine')
    # print("123")

    # pre.transDF()

    print(pre.hair_dryer)

    # # save to excel
    pre.hair_dryer.to_excel(hair_dryer_save_path)
    pre.microwave.to_excel(microwave_save_path)
    pre.pacifier.to_excel(pacifier_save_path)

    return None


def main(hair_dryer_path=None, microwave_path=None, pacifier_path=None):
    pre = preProcess(
        hair_dryer_path=hair_dryer_path,
        microwave_path=microwave_path,
        pacifier_path=pacifier_path
    )
    pre = preProcess(hair_dryer_path=hair_dryer_path,
                     microwave_path=microwave_path, pacifier_path=pacifier_path)
    # print(pre.hair_dryer)
    pre.drop_col('marketplace')  # delete marketplace
    pre.drop_col('product_category')
    # print("pre.hair_dryer.test")
    pre.del_helpful_votes_total_votes()
    # print("pre.hair_dryer.test")
    # print(pre.hair_dryer)
    hair_dryer_save_path = "./output_dataset/hair_dryer.xlsx"
    microwave_save_path = "./output_dataset/microwave.xlsx"
    pacifier_save_path = "./output_dataset/pacifier.xlsx"
    # print("123")
    pre.del_verified_purchase_N(
        hair_dryer_save_path=hair_dryer_save_path,
        microwave_save_path=microwave_save_path,
        pacifier_save_path=pacifier_save_path
    )
    pre.drop_col('verified_purchase')
    # pre.drop_col('vine')
    # print("123")
    pre.delete_error_data(sub_str='hair dryer')
    pre.mysort('product_id')
    print(pre.hair_dryer)

    # # save to excel
    pre.hair_dryer.to_excel(hair_dryer_save_path, index=False)
    pre.microwave.to_excel(microwave_save_path, index=False)
    pre.pacifier.to_excel(pacifier_save_path, index=False)
    print("finished")
    return None


if __name__ == "__main__":
    hair_dryer_path = "./dataset/hair_dryer.xlsx"
    microwave_path = "./dataset/microwave.xlsx"
    pacifier_path = "./dataset/pacifier.xlsx"

    hair_dryer_test_path = "./test_dataset/hair_dryer.xlsx"
    microwave_test_path = "./test_dataset/microwave.xlsx"
    pacifier_test_path = "./test_dataset/pacifier.xlsx"

    # test(
    #     hair_dryer_path=hair_dryer_test_path,
    #      microwave_path=microwave_test_path,
    #     pacifier_path=pacifier_test_path
    # )

    main(hair_dryer_path=hair_dryer_path,
         microwave_path=microwave_path, pacifier_path=pacifier_path)
