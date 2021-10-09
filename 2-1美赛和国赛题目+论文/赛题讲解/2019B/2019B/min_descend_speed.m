function speed = min_descend_speed( a,b,v0,e)
%ascend： 球上升过程
%  a: 球弹起的最小高度
%  b: 球碰撞高度
%  v0: 鼓在碰撞位置的速度
% speed: 使得球与鼓在b处碰撞后跳起的高度超过0.4米的最小下降速度
% M: 同心鼓的质量
% m: 球质量
% e: 碰撞恢复系数  先取e=1
M=3.6; m=0.27;
[~,~,v1]=descend(a,b);
v=min_ascend_speed(a,b);
tmp=((m+M)*v-M*(1+e)*v0)/(m-e*M);
speed=max(-1*(tmp<0)*tmp,abs(v1));
end

