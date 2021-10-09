function I=re_divide(P,col,K)
% I=re_divide(P)
% P:  K^2*N matrix
% example:
% I=re_divide(P);
% I=uint8(I*255);
% imshow(I)

% 计算大小
[~,N]=size(P);
m=sqrt(N);

% 将向量转为K*K矩阵
b44=[];
for k=1:N
    t=reshape(P(:,k),K,K);
    b44=[b44,t];
end

% 重新排布K*K矩阵
I=[];
for k=1:m
    YYchonggou_ceshi1=b44(:,(k-1)*col+1:k*col);
    I=[I;YYchonggou_ceshi1];
end
