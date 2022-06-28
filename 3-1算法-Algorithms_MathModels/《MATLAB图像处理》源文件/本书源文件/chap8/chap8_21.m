

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
s=size(I);
M=s(1);
N=s(2);
P=dctmtx(M);
Q=dctmtx(N);
J=P*I*Q';
K=dct2(I);
E=J-K;
find(abs(E)>0.000001)
figure;
subplot(121);
imshow(J);
subplot(122);
imshow(K);

