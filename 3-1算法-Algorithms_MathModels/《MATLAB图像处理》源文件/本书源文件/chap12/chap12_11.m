

clear all; close all;
I=imread('pout.tif');
se=strel('disk', 3);
J=imtophat(I, se);
K=imbothat(I, se);
L=imsubtract(imadd(I, J), K);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(L);

