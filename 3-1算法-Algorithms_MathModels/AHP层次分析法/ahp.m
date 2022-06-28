function [maxeigval,w]=ahp(A)
    %A为判断矩阵
    [eigvec,eigval]=eig(A);
    eigval=diag(eigval);   %特征向量
    eigvalmag=imag(eigval);
    realind=find(eigvalmag<eps);
    realeigval=eigval(realind) %实特征根
    maxeigval=max(realeigval) %最大特征值
    index=find(eigval==maxeigval);
    vecinit=eigvec(:,index); %最大特征值对应的特征向量
    w=vecinit./sum(vecinit); %特征向量归一化
end