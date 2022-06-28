
clear all; close all;
I=imread('cameraman.tif');
figure;
imshow(I);
brighten(0.6);
figure;
imshow(I);
brighten(-0.6);
