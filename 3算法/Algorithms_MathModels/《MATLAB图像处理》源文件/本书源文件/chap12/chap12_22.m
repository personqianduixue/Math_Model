

clear all; close all;
I=imread('circles.png');
J=bwulterode(I);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);


