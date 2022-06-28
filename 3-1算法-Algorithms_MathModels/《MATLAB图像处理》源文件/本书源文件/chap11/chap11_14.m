%【例11-14】
I= imread('leaf1.bmp');                     %读入图像 　　
I= im2bw(I);                              %转换为二值图像
C=bwlabel(I,4);                           %对二值图像进行4连通的标记
Ar=regionprops(C,'Area');                  %求C的面积
Ce=regionprops(C,'Centroid');              %求C的重心
Ar
Ce

