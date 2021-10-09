


clear all; close all;
I=imread('rice.png');
figure;
subplot(121);  imshow(I);
subplot(122);  imhist(I, 200);

