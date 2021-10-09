

clear all; close all;
RGB=imread('saturn.png');
I=rgb2gray(RGB);
I=imcrop(I, [100, 100, 1024, 1024]);
J=imnoise(I, 'gaussian', 0, 0.03);
[K, noise]=wiener2(J, [5, 5]);
figure;
subplot(121);  imshow(J);
subplot(122);  imshow(K);

