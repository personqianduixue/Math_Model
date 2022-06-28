%sand pile 
clc, clear
clf 
nx=52; %must be divisible by 4 
ny=100; 
Pbridge = .05; 
z=zeros(nx,ny); 
o=ones(nx,ny); 
sand = z ; 
sandNew = z; 
gnd = z ; 
gnd(1:nx,ny-3)=1 ; % the ground line 
gnd(nx/4:nx/2+4,ny-15)=1; %the hole line 
gnd(nx/2+6:nx,ny-15)=1; %the hole line 
gnd(nx/4, ny-15:ny) = 1; %side line 
gnd(3*nx/4, 1:ny) = 1 ; 
imh = image(cat(3,z',sand',gnd')); 
set(imh, 'erasemode', 'none') 
axis equal 
axis tight 
 
for i=1:10000
    p=mod(i,2); %margolis neighborhood 
    sand(nx/2,ny/2) = 1; %add a grain at the top 
    
    %upper left cell update 
    xind = [1+p:2:nx-2+p]; 
    yind = [1+p:2:ny-2+p]; 
    vary = rand(nx,ny)<.95 ; 
    vary1 = 1-vary; 
    
    sandNew(xind,yind) = ... 
        gnd(xind,yind).*sand(xind,yind) + ... 
        (1-gnd(xind,yind)).*sand(xind,yind).*sand(xind,yind+1) .* ... 
        (sand(xind+1,yind+1)+(1-sand(xind+1,yind+1)).*sand(xind+1,yind)); 
    sandNew(xind+1,yind) = ... 
        gnd(xind+1,yind).*sand(xind+1,yind) + ... 
        (1-gnd(xind+1,yind)).*sand(xind+1,yind).*sand(xind+1,yind+1) .* ... 
        (sand(xind,yind+1)+(1-sand(xind,yind+1)).*sand(xind,yind)); 
    
    sandNew(xind,yind+1) = ... 
        sand(xind,yind+1) + ... 
        (1-sand(xind,yind+1)) .* ... 
        ( sand(xind,yind).*(1-gnd(xind,yind)) + ... 
        (1-sand(xind,yind)).*sand(xind+1,yind).*(1-gnd(xind+1,yind)).*sand(xind+1,yind+1)); 
    
    sandNew(xind+1,yind+1) = ... 
        sand(xind+1,yind+1) + ... 
        (1-sand(xind+1,yind+1)) .* ... 
        ( sand(xind+1,yind).*(1-gnd(xind+1,yind)) + ... 
        (1-sand(xind+1,yind)).*sand(xind,yind).*(1-gnd(xind,yind)).*sand(xind,yind+1)); 
    
    %scramble the sites to make it look better 
    temp1 = sandNew(xind,yind+1).*vary(xind,yind+1) + ... 
        sandNew(xind+1,yind+1).*vary1(xind,yind+1); 
    
    temp2 = sandNew(xind+1,yind+1).*vary(xind,yind+1) + ... 
        sandNew(xind,yind+1).*vary1(xind,yind+1); 
        sandNew(xind,yind+1) = temp1; 
        sandNew(xind+1,yind+1) = temp2; 
    
    sand = sandNew; 
    set(imh, 'cdata', cat(3,z',sand',gnd') ) 
    drawnow 
end 