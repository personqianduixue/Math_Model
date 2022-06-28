%cells(.5*n-1,.5*n-1)=1; 
%cells(.5*n-2,.5*n-2)=1; 
%cells(.5*n-3,.5*n-3)=1; 
cells = (rand(n,n))<.5 ; 
%how long for each case to stability or simple oscillators 
%build an image and display it 
imh = image(cat(3,cells,z,z)); 
set(imh, 'erasemode', 'none') 
axis equal 
axis tight 
%index definition for cell update 
x = 2:n-1; 
y = 2:n-1; 
%Main event loop 
stop= 0; %wait for a quit button push 
run = 0; %wait for a draw 
freeze = 0; %wait for a freeze 
while (stop==0) 
 
 if (run==1) 
 %nearest neighbor sum 
 sum(x,y) = cells(x,y-1) + cells(x,y+1) + ... 
 cells(x-1, y) + cells(x+1,y) + ... 
 cells(x-1,y-1) + cells(x-1,y+1) + ... 
 cells(3:n,y-1) + cells(x+1,y+1); 
 % The CA rule 
 cells = (sum==3) | (sum==2 & cells); 
 %draw the new image 
 set(imh, 'cdata', cat(3,cells,z,z) ) 
 %update the step number diaplay 
 stepnumber = 1 + str2num(get(number,'string')); 
 set(number,'string',num2str(stepnumber)) 
 end 
 
 if (freeze==1) 
 run = 0; 
 freeze = 0; 
 end 
 drawnow %need this in the loop for controls to work 
end 
cells = (rand(n,n))<.5 ; 
%how long for each case to stability or simple oscillators 
%build an image and display it 
imh = image(cat(3,cells,z,z)); 
set(imh, 'erasemode', 'none') 
axis equal 
axis tight 
%index definition for cell update 
x = 2:n-1; 
y = 2:n-1; 
%Main event loop 
stop= 0; %wait for a quit button push 
run = 0; %wait for a draw 
freeze = 0; %wait for a freeze 
while (stop==0) 
 
 if (run==1) 
 %nearest neighbor sum 
 sum(x,y) = cells(x,y-1) + cells(x,y+1) + ... 
 cells(x-1, y) + cells(x+1,y) + ... 
 cells(x-1,y-1) + cells(x-1,y+1) + ... 
 cells(3:n,y-1) + cells(x+1,y+1)+... 
 cells(x,y); 
 % The CA rule 
 cells = ~((sum<4) | (sum==5)); 
 %draw the new image 
 set(imh, 'cdata', cat(3,cells,z,z) ) 
 %update the step number diaplay 
 stepnumber = 1 + str2num(get(number,'string')); 
 set(number,'string',num2str(stepnumber)) 
 end 
 
 if (freeze==1) 
 run = 0; 
 freeze = 0; 
 end 
 
 drawnow %need this in the loop for controls to work 
 
end 