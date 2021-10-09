function z=linedistance(A,B)
a=B(1:2)-B(3:4);
b=B(5:6)-B(3:4);
c=A-B(3:4);
theta1=acos(dot(a,c)/(norm(a)*norm(c)))*180/pi;
theta2=acos(dot(b,c)/(norm(b)*norm(c)))*180/pi;
if theta1>=90-0.5&&theta2>=90-0.5
    z=0;
else
    z=1;
end
