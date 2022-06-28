I=cell(11*19,1);
for i=1:n
imageName=strcat(num2str(i),'.bmp');
I{i} = imread(imageName);
end