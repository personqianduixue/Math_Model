function C = myfus_FUN(A,B)
%定义融合规则
D = logical(tril(ones(size(A)))); %提取矩阵的下三角部分
t = 0.8;                          %设置融合比例
C = B;                            %设置融合图像初值为B
C(D)  = t*A(D)+(1-t)*B(D);        %融合后的图像C的下三角融合规则
C(~D) = t*B(~D)+(1-t)*A(~D);      %融合后的图像Dd的上三角融合规则