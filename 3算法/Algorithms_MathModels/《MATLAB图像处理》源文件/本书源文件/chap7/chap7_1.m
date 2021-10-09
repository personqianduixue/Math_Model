


clear all; close all;
I=imread('gantrycrane.png');
I=rgb2gray(I);
h1=[-1, -1. -1; 2, 2, 2; -1, -1, -1];
h2=[-1, -1, 2; -1, 2, -1; 2, -1, -1];
h3=[-1, 2, -1; -1, 2, -1; -1, 2, -1];
h4=[2, -1, -1; -1, 2, -1; -1, -1, 2];
J1=imfilter(I, h1);
J2=imfilter(I, h2);
J3=imfilter(I, h3);
J4=imfilter(I, h4);
J=J1+J2+J3+J4;
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

