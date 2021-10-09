%【例10-3】
close all; clear all; clc;				%关闭所有图形窗口，清除工作空间所有变量，清空命令行
I=imread('lena.bmp');
I=im2double(I)*255;
[height,width]=size(I);				%求图像的大小
HWmatrix=zeros(height,width);
Mat=zeros(height,width);				%建立大小与原图像大小相同的矩阵HWmatrix和Mat，矩阵元素为0。
HWmatrix(1,1)=I(1,1);				%图像第一个像素值I(1,1)传给HWmatrix(1,1)
for i=2:height						%以下将图像像素值传递给矩阵Mat
    Mat(i,1)=I(i-1,1);
end
for j=2:width
    Mat(1,j)=I(1,j-1);
end
for i=2:height						%以下建立待编码的数组symbols和每个像素出现的概率矩阵p
    for j=2:width
        Mat(i,j)=I(i,j-1)/2+I(i-1,j)/2;
    end
end
Mat=floor(Mat);HWmatrix=I-Mat;
SymPro=zeros(2,1); SymNum=1; SymPro(1,1)=HWmatrix(1,1); SymExist=0;
for i=1:height
    for j=1:width
        SymExist=0;
        for k=1:SymNum
            if SymPro(1,k)==HWmatrix(i,j)
                SymPro(2,k)=SymPro(2,k)+1;
                SymExist=1;
                break;
            end
        end
        if SymExist==0
          SymNum=SymNum+1;
          SymPro(1,SymNum)=HWmatrix(i,j);
          SymPro(2,SymNum)=1;
        end
    end
end
for i=1:SymNum
    SymPro(3,i)=SymPro(2,i)/(height*width);
end
symbols=SymPro(1,:);p=SymPro(3,:);
[dict,avglen] = huffmandict(symbols,p);			%产生霍夫曼编码词典，返回编码词典dict和平均码长avglen
actualsig=reshape(HWmatrix',1,[]);
compress=huffmanenco(actualsig,dict); 			%利用dict对actuals来编码，其结果存放在compress中
UnitNum=ceil(size(compress,2)/8); 
Compressed=zeros(1,UnitNum,'uint8');
for i=1:UnitNum
    for j=1:8
        if ((i-1)*8+j)<=size(compress,2)
        Compressed(i)=bitset(Compressed(i),j,compress((i-1)*8+j));
        end
    end
end
NewHeight=ceil(UnitNum/512);Compressed(width*NewHeight)=0;
ReshapeCompressed=reshape(Compressed,NewHeight,width);
imwrite(ReshapeCompressed,'Compressed Image.bmp','bmp');
Restore=zeros(1,size(compress,2));
for i=1:UnitNum
    for j=1:8
        if ((i-1)*8+j)<=size(compress,2)
        Restore((i-1)*8+j)=bitget(Compressed(i),j);
        end
    end
end
decompress=huffmandeco(Restore,dict); 			%利用dict对Restore来解码，其结果存放在decompress中
RestoredImage=reshape(decompress,512,512);
RestoredImageGrayScale=uint8(RestoredImage'+Mat);
imwrite(RestoredImageGrayScale,'Restored Image.bmp','bmp');
figure;
subplot(1,3,1);imshow(I,[0,255]);				%显示原图
subplot(1,3,2);imshow(ReshapeCompressed);		%显示压缩后的图像
subplot(1,3,3);imshow('Restored Image.bmp');		%解压后的图像

