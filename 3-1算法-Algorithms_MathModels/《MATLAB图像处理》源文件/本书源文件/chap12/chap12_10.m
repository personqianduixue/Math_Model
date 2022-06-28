

clear all; close all;
I=imread('rice.png');
se=strel('disk', 11);
J=imtophat(I, se);
K=imadjust(J);
figure;
subplot(131);  imshow(I);
subplot(132);  imshow(J);
subplot(133);  imshow(K);

