

clear all; close all;
I=imread('rice.png');
J=I>120;
[width, height]=size(I);
for i=1:width
    for j=1:height
        if (I(i, j)>130)
            K(i, j)=1;
        else 
            K(i, j)=0;
        end
    end
end
figure;
subplot(121);  imshow(J);
subplot(122);  imshow(K);

