%diffusion + dla 
clc, clear
clf 
nx=200; %must be divisible by 4 
ny=200; 
z=zeros(nx,ny); 
o=ones(nx,ny); 
sand = z ; 
sandNew = z; 
sum = z; 
gnd = z; 
gnd(nx/2,ny/2) = 1 ; 
sand = rand(nx,ny)<.1; 
imh = image(cat(3,z,sand,gnd)); 
set(imh, 'erasemode', 'none') 
axis equal 
axis tight 
 
for i=1:10000 
    p=mod(i,2); %margolis neighborhood 
    %upper left cell update 
    xind = [1+p:2:nx-2+p]; 
    yind = [1+p:2:ny-2+p]; 
    %random velocity choice 
    vary = rand(nx,ny)<.5 ; 
    vary1 = 1-vary; 
    
    %diffusion rule -- margolus neighborhood 
    %rotate the 4 cells to randomize velocity 
    sandNew(xind,yind) = ... 
    vary(xind,yind).*sand(xind+1,yind) + ... %cw 
    vary1(xind,yind).*sand(xind,yind+1) ; %ccw 
    
    sandNew(xind+1,yind) = ... 
    vary(xind,yind).*sand(xind+1,yind+1) + ... 
    vary1(xind,yind).*sand(xind,yind) ; 
    
    sandNew(xind,yind+1) = ... 
    vary(xind,yind).*sand(xind,yind) + ... 
    vary1(xind,yind).*sand(xind+1,yind+1) ; 
    
    sandNew(xind+1,yind+1) = ... 
    vary(xind,yind).*sand(xind,yind+1) + ... 
    vary1(xind,yind).*sand(xind+1,yind) ; 
    
    sand = sandNew; 
    
    %for every sand grain see if it near the fixed, sticky cluster 
    sum(2:nx-1,2:ny-1) = gnd(2:nx-1,1:ny-2) + gnd(2:nx-1,3:ny) + ... 
        gnd(1:nx-2, 2:ny-1) + gnd(3:nx,2:ny-1) + ... 
        gnd(1:nx-2,1:ny-2) + gnd(1:nx-2,3:ny) + ... 
        gnd(3:nx,1:ny-2) + gnd(3:nx,3:ny); 
    
    %add to the cluster 
    gnd = ((sum>0) & (sand==1)) | gnd ; 
    %and eliminate the moving particle 
    sand(find(gnd==1)) = 0; 
    
    set(imh, 'cdata', cat(3,gnd,gnd,(sand==1)) ); 
    drawnow 
end 
