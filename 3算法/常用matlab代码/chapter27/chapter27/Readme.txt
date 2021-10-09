文件说明：

1. chapter27_lvq.m为主程序，将该文件夹设置为MATLAB当前工作路径，运行即可。

2. Images文件夹为10个人五个方向的50幅脸部照片。

3. feature_extraction.m为脸部特征提取子函数。

4. chapter27_bp.m为对比的BP程序，chapter_svm.m为对比的svm程序。

5. crossvalind_lvq.m为增加了交叉验证功能(确定最佳神经元个数)的LVQ程序。

6. lvq1_train.m和lvq2_train.m为自定义的LVQ训练函数(分别采用LVQ1和LVQ2学习规则)，lvq_predict.m为自定义的LVQ预测函数。
   （未使用MATLAB自带的神经网络工具箱函数，具体在配套视频中有详细讲解）

7. test.m为使用自定义的LVQ训练和预测函数的程序。

8. 该程序在MATLAB2009a版本下测试通过，个别函数在低版本中不存在或者调用格式有所不同，参照对应版本中的帮助文档修改即可。