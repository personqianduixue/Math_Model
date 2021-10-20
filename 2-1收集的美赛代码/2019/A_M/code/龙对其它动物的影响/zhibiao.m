function  dy=zhibiao(t,y)
IR1 = 4;    % growth rate of other organisms living independently
IR2 = 0.9;  % death rate when the dragon is alone
CR1 = 0.9;  % the ability of the dragon to pluck other creatures
CR2 = 0.8;  % other creatures' ability to support dragons
dy=zeros(2,1);
dy(1)=CR1*y(2)*y(1)-IR2*y(1);  % y(1) represents dragon£¬y(2) represents other creatures
dy(2)=IR1*y(2)-CR2*y(2)*y(1);  
end

