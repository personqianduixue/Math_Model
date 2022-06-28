

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
h=fspecial('laplacian');
J=imfilter(I, h, 'replicate');
K=im2bw(J, 80/255);
figure;
subplot(121);  imshow(J);
subplot(122);  imshow(K);

