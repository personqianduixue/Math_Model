

clear all; close all;
I=imread('coins.png');
I=im2double(I);
V=zeros(size(I));
for i=1:size(V, 1)
    V(i,:)=0.02*i/size(V,1);
end
J=imnoise(I, 'localvar', V);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);
