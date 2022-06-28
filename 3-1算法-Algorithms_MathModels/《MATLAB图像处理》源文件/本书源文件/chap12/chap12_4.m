


clear all; close all;
bw=imread('text.png');
se=strel('line', 11, 90);
bw2=imdilate(bw, se);
figure;
subplot(121);  imshow(bw);
subplot(122);  imshow(bw2);


