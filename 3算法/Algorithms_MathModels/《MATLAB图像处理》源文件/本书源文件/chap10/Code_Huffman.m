function B=Code_Huffman(A)
%根据huffman编码表对量化后的数据编码
%依次输入DC系数差值(A中DC系数已做过差分)和AC系数的典型Huffman表
%只处理8×8DCT系数量化矩阵，每个A都是8*8
DC_Huff={'00','010','011','100','101','110','1110','11110','111110','1111110','11111110','111111110'};
%由于AC系数数据量较大，我们将它保存在AC_Huff.txt文件中，将它读入元胞数组中
fid=fopen('AC_Huff.txt','r');
AC_Huff=cell(16,10);
for a=1:16
    for b=1:10
        temp=fscanf(fid,'%s',1);%以行为单位读取，保存在temp中
        AC_Huff(a,b)={temp};%代表每行的一组数据
    end
end
fclose(fid);
%对A中的数据进行Zig-Zag扫描，保存在数组Z中
i=1;
for a=1:15
    if a<=8
        for b=1:a
            if mod(a,2)==1
               Z(i)=A(b,a+1-b);
               i=i+1;
            else
               Z(i)=A(a+1-b,b);
               i=i+1;
            end
            
        end
    else
        for b=1:16-a
            if mod(a,2)==0
               Z(i)=A(9-b,a+b-8);
               i=i+1;
            else
               Z(i)=A(a+b-8,9-b);
               i=i+1;
            end                              
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%先对DC差值系数编码：前缀码SSSS+尾码
%dc为其Huffman编码
if Z(1)==0
    sa.s=DC_Huff(1);   %%%size分量存放前缀码
    sa.a='0';           %%%amp分量存放尾码
    dc=strcat(sa.s,sa.a);
else    
    n=fix(log2(abs(Z(1))))+1;
    sa.s=DC_Huff(n);
    sa.a=binCode(Z(1));
    dc=strcat(sa.s,sa.a);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%再对AC系数进行行程编码,保存在结构体数组rsa中
if isempty(find(Z(2:end)))  %如果63个交流系数全部为0，rsa系数全部为0
    rsa(1).r=0;             %行程runlength
    rsa(1).s=0;             %码长size
    rsa(1).a=0;             %二进制编码
else
   T=find(Z);              %找出Z中非零元素的下标
   T=[0 T(2:end)];         %为统一处理将第一个下标元素置为0
   i=1;                    % i为rsa结构体的下标  
   %从第二个元素即第一个交流元素开始处理
   j=2;
   while j<=length(T)
       t=fix((T(j)-1-T(j-1))/16);   %判断下标间隔是否超过16
       if t==0                      %如果小于16，较简单
           rsa(i).r=T(j)-T(j-1)-1;
           rsa(i).s=fix(log2(abs(Z(T(j)))))+1;
           rsa(i).a=Z(T(j));
           i=i+1;
       else                         %如果超过16，需要处理（15，0）的特殊情况
           for n=1:t                %可能出现t组（15，0） 
               rsa(i)=struct('r',15,'s',0,'a',0);
               i=i+1;
           end
           %接着处理剩余的那部分
           rsa(i).r=T(j)-1-16*t;
           rsa(i).s=fix(log2(abs(Z(T(j)))))+1;
           rsa(i).a=Z(T(j));
           i=i+1;
       end
       j=j+1;
   end
   %判断最后一个非零元素是否为Z中最后一个元素
   if T(end)<64
       rsa(i).r=0;
       rsa(i).s=0;
       rsa(i).a=0;
   end                      %以EOB结束
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%---------通过查表获取AC系数的Huffman编码

B=dc;                         %B初始化为直流系数编码
for n=1:length(rsa)
    if rsa(n).r==0&rsa(n).s==0&rsa(n).a==0
        ac(n)={'1010'};  
    elseif rsa(n).r==15&rsa(n).s==0&rsa(n).a==0
        ac(n)={'11111111001'};
    else
        t1=AC_Huff(rsa(n).s+1,rsa(n).s);
        t2=binCode(rsa(n).a);
        ac(n)=strcat(t1,t2);
      
    end
   B=strcat(B,ac(n));
end    
    
    
