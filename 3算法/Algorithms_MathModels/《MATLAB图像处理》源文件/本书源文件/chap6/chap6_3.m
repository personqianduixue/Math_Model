

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
h=0:0.1:1;
v=0.01:-0.001:0;
J=imnoise(I, 'localvar', h, v);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

