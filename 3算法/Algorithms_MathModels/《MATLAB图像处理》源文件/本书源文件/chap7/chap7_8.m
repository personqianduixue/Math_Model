

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
J=imnoise(I, 'gaussian', 0, 0.005);
[K, thresh]=edge(J, 'log', [], 2.3);
figure;
subplot(121);  imshow(J);
subplot(122);  imshow(K);
