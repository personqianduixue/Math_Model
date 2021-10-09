
clear all; close all;
I=imread('pout.tif');
row=size(I,1);
column=size(I,2);
N=zeros(1, 256);
for i=1:row
    for j=1:column
        k=I(i, j);
        N(k+1)=N(k+1)+1;
    end
end
figure;
subplot(121);
imshow(I);
subplot(122);
bar(N);
axis tight;
