

clear all; close all;
I=imread('rice.png');
I=im2double(I);
h=[0,1,0; 1, -4, 1; 0, 1, 0];
J=conv2(I, h, 'same');
K=I-J;
figure;
subplot(121);
imshow(I);
subplot(122);
imshow(K);

