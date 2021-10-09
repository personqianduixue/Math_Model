

clear all; close all;
I=imread('onion.png');
J=rgb2gray(I);
J=double(J);
s=size(J);
M=s(1); N=s(2);
for u=0:M-1
    for v=0:N-1
        k=0;
        for x=0:M-1
            for y=0:N-1
                k=J(x+1, y+1)*exp(-j*2*pi*(u*x/M+v*y/N))+k;
            end
        end
        F(u+1, v+1)=k;
    end
end
K=fft2(J);
figure;
subplot(121);
imshow(K);
subplot(122);
imshow(F);

