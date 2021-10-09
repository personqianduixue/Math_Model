function Z=fftfilter(X, H)
F=fft2(X, size(H,1), size(H, 2));
Z=H.*F;
Z=ifftshift(Z);
Z=abs(ifft2(Z));
Z=Z(1:size(X, 1), 1:size(X, 2));
end
