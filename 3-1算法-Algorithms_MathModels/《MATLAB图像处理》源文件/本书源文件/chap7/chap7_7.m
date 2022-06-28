

clear all; close all;
I=imread('rice.png');
I=im2double(I);
J=imnoise(I, 'gaussian', 0, 0.01);
[K, thresh]=edge(J, 'canny');
figure;
subplot(121);  imshow(J);
subplot(122);  imshow(K);

