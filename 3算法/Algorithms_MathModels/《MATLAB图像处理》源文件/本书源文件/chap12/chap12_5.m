

clear all; close all;
bw=imread('cameraman.tif');
se=strel('ball', 5, 5);
bw2=imdilate(bw, se);
figure;
subplot(121);  imshow(bw);
subplot(122);  imshow(bw2);

