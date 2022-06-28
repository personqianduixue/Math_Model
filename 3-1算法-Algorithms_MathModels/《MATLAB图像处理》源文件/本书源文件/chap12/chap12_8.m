

clear all; close all;
I=imread('snowflakes.png');
se=strel('disk', 5);
J=imopen(I, se);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J, []);

