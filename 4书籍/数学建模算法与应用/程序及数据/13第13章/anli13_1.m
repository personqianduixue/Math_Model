clc, clear
a=imread('tu8.bmp'); ws1=size(a);    %读入保密图像，并计算维数
b=imread('tu9.bmp'); ws2=size(b);   %读入载体图像，并计算维数
nb=imresize(b,ws1(1:2));  %把载体图像变换成与保密图像同样大小
key=-0.400001;  %给出密钥，即混沌序列的初始值
L=max(ws1); x(1)=key; y(1)=key; alpha=1.4; beta=0.3;
for i=1:L-1     %生成两个混沌序列
     x(i+1)=1-alpha*x(i)^2+y(i); y(i+1)=beta*x(i);
end
x(ws1(1,1)+1:end)=[]; %删除x后面一部分元素
[sx,ind1]=sort(x); [sy,ind2]=sort(y); %对混沌序列按照从小到大排序
ea(ind1,ind2,:)=a; %打乱保密图像的行序和列序，生成加密图像矩阵ea
imshow(ea) %显示保密图像加密后得到的图像
nb2=bitand(nb,240); %载体图像与11110000(（二进制）=240(十进制）)逐位与运算
ea2=bitand(ea,240); %加密图像与11110000逐位与运算
ea2=ea2/16; %加密图像高4位移到低4位
da=bitor(nb2,ea2); %把加密图像嵌入载体图像的低4位，构造合成图像
da2=bitand(da,15)*16; %这里15（十进制）=00001111,提取加密图像的高4位，
da3=da2(ind1,ind2,:); %对加密图像进行解密
figure, subplot(1,2,1), imshow(da3) %显示提取的并解密以后的原图像
subplot(1,2,2),imshow(da) %显示嵌入加密图像的合成图像
