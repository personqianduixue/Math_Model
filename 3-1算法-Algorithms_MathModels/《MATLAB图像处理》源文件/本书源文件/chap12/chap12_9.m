

clear all; close all;
I=imread('circles.png');
se=strel('disk', 10);
J=imclose(I, se);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J, []);

