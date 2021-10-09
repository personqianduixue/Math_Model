%% Percolation Cluster
clf 
clc, clear
threshold = .63; 
% 
ax = axes('units','pixels','position',[1 1 650 700],'color','k'); 
text('units', 'pixels', 'position', [150,255,0],... 
    'string','美赛','color','w','fontname','helvetica','fontsize',100) 
text('units', 'pixels', 'position', [40,120,0],... 
    'string','冲锋小队','color','w','fontname','helvetica','fontsize',100) 
initial = getframe(gca); 
[a,b,c]=size(initial.cdata); 
z=zeros(a,b); 
cells = double(initial.cdata(:,:,1)==255); 
visit = z ; 
sum = z; 
imh = image(cat(3,z,cells,z)); 
set(imh, 'erasemode', 'none') 
%return 
for i=1:1000
    sum(2:a-1,2:b-1) = cells(2:a-1,1:b-2) + cells(2:a-1,3:b) + ... 
    cells(1:a-2, 2:b-1) + cells(3:a,2:b-1) + ... 
    cells(1:a-2,1:b-2) + cells(1:a-2,3:b) + ... 
    cells(3:a,1:b-2) + cells(3:a,3:b); 
    
    pick = rand(a,b); 
    %edges only 
    %cells = (cells & (sum<8)) | ((sum>=1) & (pick>=threshold) & (visit==0)) ; 
    cells = cells | ((sum>=1) & (pick>=threshold) & (visit==0)) ; 
    visit = (sum>=1) ;%& (pick<threshold) ; 
    
    set(imh, 'cdata', cat(3,z,cells,z) ) 
    drawnow 
end 
return 
figure(2) 
image(cat(3,z,cells,z)) 