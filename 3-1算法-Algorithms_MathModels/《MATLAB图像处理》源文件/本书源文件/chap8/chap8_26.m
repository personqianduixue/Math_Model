

clear all; close all;
I=imread('peppers.png');
I=rgb2gray(I);
I=im2double(I);
h1=size(I, 1);
h2=size(I, 2);
H1=hadamard(h1);
H2=hadamard(h2);
J=H1*I*H2/sqrt(h1*h2);
figure;
set(0,'defaultFigurePosition',[100,100,1000,500]);
set(0,'defaultFigureColor',[1 1 1])
subplot(121);
imshow(I);
subplot(122);
imshow(J);

