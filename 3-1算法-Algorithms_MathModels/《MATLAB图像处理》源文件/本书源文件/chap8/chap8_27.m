

clear all; close all;
I=imread('circuit.tif');
I=im2double(I);
BW=edge(I, 'canny');
[H, Theta, Rho]=hough(BW, 'RhoResolution', 0.5, 'ThetaResolution', 0.5);
figure;
set(0,'defaultFigurePosition',[100,100,1000,500]);
set(0,'defaultFigureColor',[1 1 1])
subplot(121);
imshow(BW);
subplot(122);
imshow(imadjust(mat2gray(H)));
axis normal;
hold on;
colormap hot;
