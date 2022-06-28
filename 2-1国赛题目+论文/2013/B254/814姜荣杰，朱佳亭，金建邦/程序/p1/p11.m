a1=imread('000.bmp');
[m,n]=size(a1);
a=zeros(m,n,19);
%¶ÁÍ¼
a(:,:,1)=imread('000.bmp');
a(:,:,2)=imread('001.bmp');
a(:,:,3)=imread('002.bmp');
a(:,:,4)=imread('003.bmp');
a(:,:,5)=imread('004.bmp');
a(:,:,6)=imread('005.bmp');
a(:,:,7)=imread('006.bmp');
a(:,:,8)=imread('007.bmp');
a(:,:,9)=imread('008.bmp');
a(:,:,10)=imread('009.bmp');
a(:,:,11)=imread('010.bmp');
a(:,:,12)=imread('011.bmp');
a(:,:,13)=imread('012.bmp');
a(:,:,14)=imread('013.bmp');
a(:,:,15)=imread('014.bmp');
a(:,:,16)=imread('015.bmp');
a(:,:,17)=imread('016.bmp');
a(:,:,18)=imread('017.bmp');
a(:,:,19)=imread('018.bmp');
d=zeros(19,19);
e=size(d);
[m,n]=size(a(:,:,1));
%¼ÆËãÆ¥Åä¶È
for i=1:e
    for j=1:e
        if i~=j
        s=a(:,n,i)==a(:,1,j);
      d(i,j)=d(i,j)+sum(sum(s'));
        end
    end
end
%È¡µ¹Êı
for i=1:e
    for j=1:e
        if i~=j
      d(i,j)=1/d(i,j);
        end
    end
end
tou=zeros(e,1);
%ÅĞ¶ÏÍ·
for i=1:e
        s=a(:,1,i)==255;
      tou(i,1)=tou(i,1)+sum(s);
end
[mt,t]=max(tou);
wei=zeros(e,1);
%ÅĞ¶ÏÎ²
for i=1:e
      s=a(:,n,i)==255;
      wei(i)=wei(i)+sum(s);
end
[mw,w]=max(wei);
%»­Í¼
b=[a(:,:,9),a(:,:,15),a(:,:,13),a(:,:,16),a(:,:,4),a(:,:,11),a(:,:,3),a(:,:,17),a(:,:,2),a(:,:,5),a(:,:,6),a(:,:,10),a(:,:,14),a(:,:,19),a(:,:,12),a(:,:,8),a(:,:,18),a(:,:,1),a(:,:,7)];
double(b);
imshow(b,[])