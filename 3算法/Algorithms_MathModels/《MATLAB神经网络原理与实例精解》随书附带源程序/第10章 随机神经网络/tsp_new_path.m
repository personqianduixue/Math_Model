function new_path = tsp_new_path(old_path)
% 在oldpath附近产生新的路径

N=length(old_path);

if rand<0.25   % 产生两个位置，并交换
    chpos = ceil(rand(1,2)*N);
    new_path = old_path;
    new_path(chpos(1)) = old_path(chpos(2));
    new_path(chpos(2)) = old_path(chpos(1));
    
else            % 产生三个位置，交换a-b和b-c段
    d=ceil(rand(1,3)*N);
    d=sort(d);
    a=d(1);b=d(2);c=d(3);
    if a~=b && b~=c
        new_path=old_path;
        new_path(a+1:c-1) = [old_path(b:c-1),old_path(a+1:b-1)];
    else
        new_path = tsp_new_path(old_path);
    end
    
end
