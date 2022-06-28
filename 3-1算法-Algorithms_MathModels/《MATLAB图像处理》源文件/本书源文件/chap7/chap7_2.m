

clear all; close all;
I=imread('rice.png');
I=im2double(I);
[J, thresh]=edge(I, 'roberts', 35/255);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);