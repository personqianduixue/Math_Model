function Gabor= Gabor_hy(Sx,Sy,f,theta,sigma)
% Sx,Sy是滤波器窗口长度，f是中心频率，theta是滤波器的方向，sigma是高斯窗的方差
x = -fix(Sx):fix(Sx); %Gabor滤波器的窗口长度
y = -fix(Sy):fix(Sy);
[x y]=meshgrid(x,y);
xPrime = x*cos(theta) + y*sin(theta);
yPrime = y*cos(theta) - x*sin(theta);
Gabor = (1/(2*pi*sigma.^2)) .* exp(-.5*(xPrime.^2+yPrime.^2)/sigma.^2).*... %Gabor滤波器
                  (exp(j*f*xPrime)-exp(-(f*sigma)^2/2)); 


