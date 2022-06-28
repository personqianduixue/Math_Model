

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
T0=0.01;
T1=(min(I(:))+max(I(:)))/2;
r1=find(I>T1);
r2=find(I<=T1);
T2=(mean(I(r1))+mean(I(r2)))/2;
while abs(T2-T1)<T0
    T1=T2;
    r1=find(I>T1);
    r2=find(I<=T1);
    T2=(mean(I(r1))+mean(I(r2)))/2;
end
J=im2bw(I, T2);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

