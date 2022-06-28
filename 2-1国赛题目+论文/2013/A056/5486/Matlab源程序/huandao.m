function huandao(i,j)
prob = 0.8;
global TONG DU road;
if rand<=prob
 if rand>0.5 
     if road(i-1,j) == TONG
        road(i,j) = TONG;
        road(i-1,j) = DU;   
        flag(i-1,j) = 1;
     elseif road(i+1,j) == TONG
        road(i,j) = TONG;
        road(i+1,j) = DU;            
        flag(i+1,j) = 1;
     end

 else
     if road(i+1,j) == TONG
        road(i,j) = TONG;
        road(i+1,j) = DU;         
        flag(i+1,j) = 1;
     elseif road(i-1,j) == TONG
        road(i,j) = TONG;
        road(i-1,j) = DU;            
        flag(i-1,j) = 1;
     end             
 end 
end