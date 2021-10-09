SVM_GUI v3.1
Based on libsvm-FarutoUltimate3.1
by faruto @ www.matlabsky.com
QQ:516667408
====================================支持右键存储图片
一点使用说明：

1 此SVM_GUI是基于libsvm-FarutoUltimate，所以你需要实现安装该工具箱。会用libsvm-FarutoUltimate的朋友，这个GUI一看就会用，里面的参数的输入就是原来libsvm-FarutoUltimate里面的输入要求，不多说了。

2 关于数据载入（load）
=================
目前只能载入.mat文件，分类问题里面需要含有以下变量(格式要求都和libsvm一样不多说)
train_data
train_label
test_data
teat_label

注：变量名需要是上述的名字，测试集和标签没有也行，即只有
train_data，train_label也可，程序会默认认为测试集和训练集一样。
=================
目前只能载入.mat文件，回归问题里面需要含有以下变量(格式要求都和libsvm一样不多说)
train_x
train_y
test_x
teat_y

注：变量名需要是上述的名字，测试集和标签没有也行，即只有
train_x，train_y也可，程序会默认认为测试集和训练集一样

3 关于保存数据（save）
可以将如下的变量进行保存
train_data (train_x)
train_label (train_y)
test_data (test_x)
teat_label (test_y)
Model     %SVM模型
pretrain  %预测的训练集标签(因变量)
pretest   %预测的测试集标签(因变量)
