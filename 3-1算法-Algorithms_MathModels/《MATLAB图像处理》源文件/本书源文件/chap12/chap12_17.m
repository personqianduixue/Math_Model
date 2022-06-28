

clear all; close all;
I=imread('rice.png');
se=strel('disk', 2);
J=imdilate(I, se);
K=imerode(I, se);
L=J-K;
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(L);

