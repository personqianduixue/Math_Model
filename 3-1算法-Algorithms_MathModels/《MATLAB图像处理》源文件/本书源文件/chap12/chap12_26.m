

clear all; close all;
I=imread('text.png');
c=[43, 185, 212];
r=[38, 68, 181];
J=bwselect(I, c, r, 4);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

