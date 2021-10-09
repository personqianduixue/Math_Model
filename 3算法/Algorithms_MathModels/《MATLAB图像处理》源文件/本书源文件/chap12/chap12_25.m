

clear all; close all;
I=imread('rice.png');
J=im2bw(I, graythresh(I));
K=bwlabel(J);
RGB=label2rgb(K);
figure;
subplot(121);  imshow(J);
subplot(122);  imshow(RGB);

