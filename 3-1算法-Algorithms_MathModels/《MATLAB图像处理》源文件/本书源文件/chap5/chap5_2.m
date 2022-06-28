
clear all; close all;
I=imread('pout.tif');
I=double(I);
J=(I-80)*255/70;
row=size(I,1);
column=size(I,2);
for i=1:row
    for j=1:column
        if J(i, j)<0
            J(i, j)=0;
        end
        if J(i, j)>255;
            J(i, j)=255;
        end
    end
end
figure;
subplot(121);
imshow(uint8(I));
subplot(122);
imshow(uint8(J));

