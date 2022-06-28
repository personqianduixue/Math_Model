function OutImage=mirror(InImage,n)
%mirror函数实现图像镜像变换功能
%参数n为1时，实现水平镜像变换
%参数n为2时，实现垂直镜像变换
%参数n为3时，实现水平垂直镜像变换
I=InImage;
[M,N,G]=size(I);%获取输入图像I的大小
J=I;  %初始化新图像矩阵全为1，大小与输入图像相
if (n==1)
    for i=1:M
        for j=1:N
            J(i,j,:)=I(M-i+1,j,:);%n=1,水平镜像
        end
    end;
elseif (n==2)
     for i=1:M
        for j=1:N
            J(i,j,:)=I(i,N-j+1,:);%n=2,垂直镜像
        end
     end    
elseif (n==3)
     for i=1:M
        for j=1:N
            J(i,j,:)=I(M-i+1,N-j+1,:);%n=3,水平垂直镜像
        end
     end
else
    error('参数n输入不正确，n取值1、2、3')%n输入错误时提示
end
    OutImage=J;

    