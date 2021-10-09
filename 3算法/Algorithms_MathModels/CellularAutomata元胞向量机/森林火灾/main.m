%CA driver 
% 
%forest fire 
clf 
clear all 
n=100; 
Plightning = .000005; 
Pgrowth = .01; %.01 
z=zeros(n,n); 
o=ones(n,n); 
veg=z; 
sum=z; 
imh = image(cat(3,z,veg*.02,z)); 
set(imh, 'erasemode', 'none') 
axis equal 
axis tight 
 
% burning -> empty 
% green -> burning if one neigbor burning or with prob=f (lightning) 
% empty -> green with prob=p (growth) 
% veg = {empty=0 burning=1 green=2} 
for i=1:3000 
    %nearby fires? 
    sum = (veg(1:n,[n 1:n-1])==1) + (veg(1:n,[2:n 1])==1) + ... 
    (veg([n 1:n-1], 1:n)==1) + (veg([2:n 1],1:n)==1) ; 
    
    veg = ... 
    2*(veg==2) - ((veg==2) & (sum>0 | (rand(n,n)<Plightning))) + ... 
    2*((veg==0) & rand(n,n)<Pgrowth) ; 
    
    set(imh, 'cdata', cat(3,(veg==1),(veg==2),z) ) 
    drawnow 
end 