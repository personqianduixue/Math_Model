%%Conway's life with GUI 
clf            % Çå³ýÍ¼ÐÎ
clc, clear

%=========================== 
%build the GUI 
%define the plot button 
plotbutton=uicontrol('style','pushbutton',... 
    'string','Run', ... 
    'fontsize',12, ... 
    'position',[100,400,50,20], ... 
    'callback', 'run=1;'); 
%define the stop button 
erasebutton=uicontrol('style','pushbutton',... 
    'string','Stop', ... 
    'fontsize',12, ... 
    'position',[200,400,50,20], ... 
    'callback','freeze=1;'); 
%define the Quit button 
quitbutton=uicontrol('style','pushbutton',... 
    'string','Quit', ... 
    'fontsize',12, ... 
    'position',[300,400,50,20], ... 
    'callback','stop=1;close;'); 
number = uicontrol('style','text', ... 
    'string','1', ... 
    'fontsize',12, ... 
    'position',[20,400,50,20]); 
%============================== 

%CA setup 
n=128; 
%initialize the arrays 
z = zeros(n,n); 
cells = z; 
sum = z; 
%set a few cells to one 
cells(n/2,.25*n:.75*n) = 1; 
cells(.25*n:.75*n,n/2) = 1; 
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