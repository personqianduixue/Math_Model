%【例11-8】
I=imread('hill.jpg');
HSV=rgb2hsv(I);
Hgray=rgb2gray(HSV);
%计算64位灰度共生矩阵
glcms1=graycomatrix(Hgray,'numlevels',64,'offset',[0 1;-1 1;-1 0;-1 -1]);
%纹理特征统计值(包括对比度、相关性、熵、平稳度、二阶矩也叫能量)
stats=graycoprops(glcms1,{'contrast','correlation','energy','homogeneity'});
ga1=glcms1(:,:,1);%0度
ga2=glcms1(:,:,2);%45度
ga3=glcms1(:,:,3);%90度
ga4=glcms1(:,:,4);%135度
energya1=0;energya2=0;energya3=0;energya4=0;
for i=1:64
    for j=1:64
        energya1=energya1+sum(ga1(i,j)^2);
         energya2=energya2+sum(ga2(i,j)^2);
          energya3=energya3+sum(ga3(i,j)^2);
           energya4=energya4+sum(ga4(i,j)^2);
           j=j+1;
    end
    i=i+1;
end
s1=0;s2=0;s3=0;s4=0;s5=0;
for m=1:4
    s1=stats.Contrast(1,m)+s1;
    m=m+1;
end
for m=1:4
    s2=stats.Correlation(1,m)+s2;
    m=m+1;
end
for m=1:4
    s3=stats.Energy(1,m)+s3;
    m=m+1;
end
for m=1:4
    s4=stats.Homogeneity(1,m)+s4;
    m=m+1;
end
s5=0.000001*(energya1+energya2+energya3+energya4);
I=imread('hill.jpg');
J=imread('sea.jpg');
K=imread('house.jpg');
set(0,'defaultFigurePosition',[100,100,1000,500]);	%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])
figure;subplot(131);imshow(I);
subplot(132);imshow(J);
subplot(133);imshow(K);

















          

