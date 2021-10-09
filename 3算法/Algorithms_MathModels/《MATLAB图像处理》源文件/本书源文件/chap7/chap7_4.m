

clear all; close all;
I=imread('gantrycrane.png');
I=rgb2gray(I);
I=im2double(I);
[J, thresh]=edge(I, 'sobel', [], 'horizontal');
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

