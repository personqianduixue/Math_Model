clc, clear
for i=1:10
    str=['jpg',int2str(i),'.jpg'];
    a(:,:,1)=rand(500); a(:,:,2)=rand(500)+100; a(:,:,3)=rand(500)+200;
    imwrite(a,str);
end
