%% 森林火灾
% (1)正在燃烧的树变成空格位；
% (2)如果绿树格位的最近邻居中有一个树在燃烧，
%   则它变成正在燃烧的树；
% (3)在空格位，树以概率p生长；
% (4)在最近的邻居中没有正在燃烧的树的情况下树
%   在每一时步以概率f(闪电)变为正在燃烧的树。
clear
clc
clear all
%地图大小
n=100;
%被闪电击中的概率
Plightning =0.000005;
%空地生长出树的概率
Pgrowth = 0.01;
z=zeros(n,n);
o=ones(n,n);
veg=z;
sum=z;
imh = image(cat(3,z,veg*0.02,z));
set(imh, 'erasemode', 'none')
axis equal
axis tight
for i=1:300
    sum = (veg(1:n,[n 1:n-1])==1) + (veg(1:n,[2:n 1])==1) + ...
        (veg([n 1:n-1], 1:n)==1) + (veg([2:n 1],1:n)==1) ;
    veg = ...
        2*(veg==2) - ((veg==2) & (sum>0 | (rand(n,n)<Plightning))) + ...
        2*((veg==0) & rand(n,n)<Pgrowth) ;    
    set(imh, 'cdata', cat(3,(veg==1),(veg==2),z) )
    pause(0.02)
end
