sh=[4 6 7	8	9	14	15	16	18	21	22	25	26	27	28	29	31	34	37	38	41	42	44	46	47	49	50	52	54	55	59	60	61	62	63	69	70	71	74	77	78	79	80	81	82	85	92	93	95	99	101	102	104	108	109	111	112	113	114	117	119	120	124	128	131	134	136	137	138	143	144	145	147	149	151	159	162	163	164	165	168	169	170	171	174	175	179	180	188	190	193	196	197	198	199	200	202	204	207	208]';
xia=[2	3 5	7	8	9	12	16	18	19	22	27	29	32	33	34	37	39	40	42	43	44	46	50	51	54	62	64	65	66	68	69	74	76	77	79	80	81	86	91	92	95	97	98	100	101	102	105	106	107	109	110	115	117	120	121	123	124	130	136	137	139	140	143	144	147	148	149	150	154	155	157	160	161	162	165	166	171	173	174	175	176	180	181	185	188	191	192	199	200	203	204	205	208	209]';
a1=imread('000.bmp');
[m,n]=size(a1);
for i=0:11*19-1
    if i<10
imageName=strcat('0','0',int2str(i),'.bmp');
    elseif i<100
            imageName=strcat('0',num2str(i),'.bmp');
    else
        imageName=strcat(num2str(i),'.bmp');
    end
aa(:,:,i+1) = imread(imageName);
end
d=zeros(209,209);
for i=1:11*19
    for j=1:11*19
        if i~=j
        s=abs(aa(m,:,i)-aa(1,:,j));
        d(i,j)=d(i,j)+sum(sum(s'));
        end
    end
end
for i=1:size(xia)
    for j=1:size(sh)
        ss9(i,j)=d(xia(i),sh(j));
    end
end
t1=zeros(180,11*19);
for i=1:11*19
    for j=1:m
         ss=0;
        for l=1:n
       ss=ss+(aa(j,l,i)==255);
        end
          t1(j,i)=ss;
    end
end
dt=diff(t1);
[u3,r3]=sort(dt);
[ma,ind]=max(dt);
N=63;
for i=1:209
z=fix(ind(i)/N);
ind(i)=ind(i)-z*N;
end
for i=1:size(xia)
    for j=1:size(sh)
        ss2(i,j)=abs(N-sum([ind(xia(i)),ind(sh(j))]'));
    end
end
ma=max(max(ss2));
ma2=max(max(ss9));
ss2=ss2/ma;
ss9=ss9/ma2;
juli=ss9+ss2;
[mi,ind]=min(juli');
size=size(ind');
for i=1:95
b=[aa(:,:,1) aa(:,:,ind(i))];
figure
imshow(b);
end



