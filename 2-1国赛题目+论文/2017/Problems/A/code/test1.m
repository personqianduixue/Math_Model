figure
imshow(A)
for i=1:4
    figure
    eval(['imshow(AS',num2str(i),')'])
end