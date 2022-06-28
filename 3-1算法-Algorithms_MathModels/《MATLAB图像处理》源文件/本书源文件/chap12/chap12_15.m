

clear all; close all;
I=imread('glass.png');
J=imextendedmax(I, 80);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

