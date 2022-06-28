

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
[m, n]=size(I);
M=2*m; n=2*n;
u=-m/2:m/2-1;
v=-n/2:n/2-1;
[U, V]=meshgrid(u, v);
D=sqrt(U.^2+V.^2);
D0=130;
H=exp(-(D.^2)./(2*(D0^2)));
N=0.01*ones(size(I,1), size(I,2));
N=imnoise(N, 'gaussian', 0, 0.001);
J=fftfilter(I, H)+N;
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J, [ ]);
HC=zeros(m, n);
M1=H>0.1;
HC(M1)=1./H(M1);
K=fftfilter(J, HC);
HC=zeros(m, n);
M2=H>0.01;
HC(M2)=1./H(M2);
L=fftfilter(J, HC);
figure;
subplot(121);  imshow(K, [ ]);
subplot(122);  imshow(L, [ ]);



