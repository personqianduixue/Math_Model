# Analytic Hierarchy Process

import numpy as np


# class myAHP
class myAHP:
    # __init__(self)
    def __init__(self):
        # print("__init__(self).start...")

        self.RI_dict = {
             1: 0,       2: 0,        3: 0.58,    4: 0.90,    5:  1.12,   6: 1.24,    7: 1.32,
             8: 1.41,    9: 1.45,    10: 1.51,   11: 1.54,   12: 1.56,   13: 1.57,   14: 1.59,
            15: 1.59,   16: 1.60,    17: 1.61,   18: 1.62,   19: 1.63,   20: 1.64
        }
        self.comparison_matrix = np.array([
            [0.50, 0.77, 0.48, 0.68, 0.47, 0.38],
            [0.23, 0.50, 0.28, 0.45, 0.32, 0.23],
            [0.52, 0.72, 0.50, 0.75, 0.48, 0.40],
            [0.32, 0.55, 0.25, 0.50, 0.23, 0.20],
            [0.53, 0.68, 0.52, 0.77, 0.50, 0.48],
            [0.62, 0.77, 0.60, 0.80, 0.52, 0.50]
        ])
    # __init__(self)

    # get_w(array)
    def get_w(self, array):
        print("get_w(array).start...")

        row = array.shape[0]

        a_axis_0_sum = array.sum(axis=0)
        # print(a_axis_0_sum)

        b = array / a_axis_0_sum  # new matrix b
        # print(b)

        b_axis_0_sum = b.sum(axis=0)
        b_axis_1_sum = b.sum(axis=1)  #
        print("b_axis_1_sum")
        print(b_axis_1_sum)

        w = b_axis_1_sum / row  #

        nw = w * row

        AW = (w * array).sum(axis=1)
        print("AW:")
        print(AW)

        max_max = sum(AW / (row * w))
        print("max_max:")
        print(max_max)

        # calculating
        print("calculating")
        CI = (max_max - row) / (row - 1)
        print("CI:")
        print(CI)
        print("row:")
        print(row)
        print("RI_dictt[row]")
        print(self.RI_dict[row])
        print("/*------------------------*/")
        CR = CI / self.RI_dict[row]
        print("over!")

        if CR < 0.1:
            print("CR:")
            print(CR)
            # print(round(CR, 3))
            print('success!!')
            return w
        else:
            print(round(CR, 3))
            print('please modify your data')

        print("get_w(array).end...")
    # get_w(array)

    # def main(array)
    def mainAlgorithm(self, array):
        print("main(array).start...")

        if type(array) is np.ndarray:
            result = self.get_w(array)
            return result
        else:
            print('please input an instance of numpy')

        print("main(array).start...")
    # def main(array)

    # comparison_economic_function()
    def comparison_function(self):
        print("comparison_function(self).start...")

        e = np.array([
            [1,   2,   7,   5],
            [1/2, 1,   4,   3],
            [1/7, 1/4, 1,   2],
            [1/5, 1/4, 1/2, 1]
        ])

        a = self.comparison_matrix
        b = self.comparison_matrix
        c = self.comparison_matrix
        d = self.comparison_matrix
        f = self.comparison_matrix

        # print("e")
        e = self.mainAlgorithm(e)
        # print("e")


        # print("a")
        a = self.mainAlgorithm(a)
        # print("a")

        # print("b")
        b = self.mainAlgorithm(b)
        # print("b")

        # print("c")
        c = self.mainAlgorithm(c)
        # print("c")

        # print("d")
        d = self.mainAlgorithm(d)
        # print("d")

        try:
            print("try")

            # res = np.array([a, b, c, d, f])
            res = np.array([a, b, c, d])
            # print("res:")
            # print(res)

            resT = np.transpose(res)
            # print("resT:")
            # print(resT)
            # print("e:")
            # print(e)
            print("ret:")
            ret = (resT * e).sum(axis=1)
            print(ret)
            print("try.end: ret")
            return ret
        except TypeError:
            print('data error')

        print("comparison_function(self).end...")
    # comparison_function()
# class myAHP


# __main__
if __name__ == '__main__':
    print("MyAHP.py__main__.start...")
    ahp = myAHP()
    ahp.comparison_function()
    print("MyAHP.py__main__.end...")
# __main__
