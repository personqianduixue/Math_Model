

clear all; close all;
I=imread('circbw.tif');
se=strel('disk', 3);
J=imdilate(I, se);
a1=bwarea(I)
a2=bwarea(J)
(a2-a1)/a1
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

