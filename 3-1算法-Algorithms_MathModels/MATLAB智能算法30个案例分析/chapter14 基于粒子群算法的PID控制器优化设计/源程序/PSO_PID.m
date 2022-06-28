function z=PSO_PID(x)
assignin('base','Kp',x(1));
assignin('base','Ki',x(2));
assignin('base','Kd',x(3));
[t_time,x_state,y_out]=sim('PID_Model',[0,20]);
z=y_out(end,1);