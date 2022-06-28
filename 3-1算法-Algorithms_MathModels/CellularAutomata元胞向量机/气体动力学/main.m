%CA driver 
%HPP-gas 
clc, clear
clf 
nx=52; %must be divisible by 4 
ny=100; 
z=zeros(nx,ny); 
o=ones(nx,ny); 
sand = z ; 
sandNew = z; 
gnd = z ; 
diag1 = z; 
diag2 = z; 
and12 = z; 
or12 = z; 
sums = z; 
orsum = z; 
gnd(1:nx,ny-3)=1 ; % right ground line 
gnd(1:nx,3)=1 ; % left ground line 
gnd(nx/4:nx/2-2,ny/2)=1; %the hole line 
gnd(nx/2+2:nx,ny/2)=1; %the hole line 
gnd(nx/4, 1:ny) = 1; %top line 
gnd(3*nx/4, 1:ny) = 1 ;%bottom line 
%fill the left side 
r = rand(nx,ny); 
sand(nx/4+1:3*nx/4-1, 4:ny/2-1) = r(nx/4+1:3*nx/4-1, 4:ny/2-1)<0.3; 
%sand(nx/4+1:3*nx/4-1, ny*.75:ny-4) = r(nx/4+1:3*nx/4-1, ny*.75:ny-4)<0.75; 
%sand(nx/2,ny/2) = 1; 
%sand(nx/2+1,ny/2+1) = 1; 
imh = image(cat(3,z,sand,gnd)); 
set(imh, 'erasemode', 'none') 
axis equal 
axis tight 

for i=1:1000 
    p=mod(i,2); %margolis neighborhood 
    
    %upper left cell update 
    xind = [1+p:2:nx-2+p]; 
    yind = [1+p:2:ny-2+p]; 
    
    %See if exactly one diagonal is ones 
    %only (at most) one of the following can be true! 
    diag1(xind,yind) = (sand(xind,yind)==1) & (sand(xind+1,yind+1)==1) & ... 
    (sand(xind+1,yind)==0) & (sand(xind,yind+1)==0); 
    
    diag2(xind,yind) = (sand(xind+1,yind)==1) & (sand(xind,yind+1)==1) & ... 
    (sand(xind,yind)==0) & (sand(xind+1,yind+1)==0); 
    
    %The diagonals both not occupied by two particles 
    and12(xind,yind) = (diag1(xind,yind)==0) & (diag2(xind,yind)==0); 
    
    %One diagonal is occupied by two particles 
    or12(xind,yind) = diag1(xind,yind) | diag2(xind,yind); 
    
    %for every gas particle see if it near the boundary 
    sums(xind,yind) = gnd(xind,yind) | gnd(xind+1,yind) | ... 
    gnd(xind,yind+1) | gnd(xind+1,yind+1) ; 
    
    % cell layout: 
    % x,y x+1,y 
    % x,y+1 x+1,y+1 
    %If (no walls) and (diagonals are both not occupied) 
    %then there is no collision, so move opposite cell to current cell 
    %If (no walls) and (only one diagonal is occupied) 
    %then there is a collision so move ccw cell to the current cell 
    %If (a wall) 
    %then don't change the cell (causes a reflection) 
    sandNew(xind,yind) = ... 
    (and12(xind,yind) & ~sums(xind,yind) & sand(xind+1,yind+1)) + ... 
    (or12(xind,yind) & ~sums(xind,yind) & sand(xind,yind+1)) + ... 
    (sums(xind,yind) & sand(xind,yind)); 
    
    sandNew(xind+1,yind) = ... 
    (and12(xind,yind) & ~sums(xind,yind) & sand(xind,yind+1)) + ... 
    (or12(xind,yind) & ~sums(xind,yind) & sand(xind,yind))+ ... 
    (sums(xind,yind) & sand(xind+1,yind)); 
    sandNew(xind,yind+1) = ... 
    (and12(xind,yind) & ~sums(xind,yind) & sand(xind+1,yind)) + ... 
    (or12(xind,yind) & ~sums(xind,yind) & sand(xind+1,yind+1))+ ... 
    (sums(xind,yind) & sand(xind,yind+1)); 
    
    sandNew(xind+1,yind+1) = ... 
    (and12(xind,yind) & ~sums(xind,yind) & sand(xind,yind)) + ... 
    (or12(xind,yind) & ~sums(xind,yind) & sand(xind+1,yind))+ ... 
    (sums(xind,yind) & sand(xind+1,yind+1)); 
    
    sand = sandNew; 
    
    set(imh, 'cdata', cat(3,z,sand,gnd) ) 
    drawnow 
end 
