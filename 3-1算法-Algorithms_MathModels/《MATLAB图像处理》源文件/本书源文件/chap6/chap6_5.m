

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
R=rand(size(I));
J=I;
J(R<=0.02)=0;
K=I;
K(R<=0.03)=1;
figure;
subplot(121);  imshow(J);
subplot(122);  imshow(K);

