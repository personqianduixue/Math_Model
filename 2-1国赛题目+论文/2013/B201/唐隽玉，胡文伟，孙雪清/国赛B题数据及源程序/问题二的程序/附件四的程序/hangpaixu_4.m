AA=[21	42	109	117	137	74	37	208	136	16	77	44	200	46	174	80	162	180	144
133	182	96	70	168	164	167	189	112	145	207	4	131	35	14	111	26	28	179
87	52	108	30	41	159	187	99	25	118	151	6	60	59	93	31	38	47	128
209	22	8	50	62	120	34	143	169	63	170	55	193	134	119	190	163	198	113
172	43	67	206	11	158	75	146	84	135	56	19	57	36	17	10	184	153	45
160	140	2	130	64	139	154	54	39	124	121	176	86	51	161	188	98	204	32
192	76	12	155	191	185	3	105	181	65	107	5	150	33	205	66	40	68	148
71	85	61	15	69	175	138	196	9	48	173	157	97	24	100	123	91	186	110
82	78	129	201	132	53	126	141	194	88	90	49	73	13	178	125	1	103	116
20	195	94	142	89	122	127	106	156	115	177	183	152	23	58	203	72	166	83
202	149	171	197	199	95	114	165	79	104	92	81	102	27	101	7	18	29	147];


for i=1:11
    tp1=[];
    for j=1:19
        tp1=[tp1 a{AA(i,j)}];
    end
    hang{i}=tp1;
end
%tp1=hang{1};
%for i=1:180
%    if sum(tp1(i,:))<=56
%        AB(i)=0;
%    else AB(i)=1;
%    end
swxw=[];syxy=[];swxy=[];syxw=[];
for i=1:11
    temp=hang{i};
    sh=sum(temp(1,:));xh=sum(temp(180,:));
    if sh==1368 
        if xh==1368
        swxw=[swxw i];
        end
    end
    if sh==1368 
        if xh<1368
        swxy=[swxy i];
        end
    end
    if sh<1368
        if xh==1368
        syxw=[syxw i];
        end
    end
    if sh<1368 
        if xh<1368
        syxy=[syxy i];
        end
    end
end

for i=1:3
    org=hang{swxy(i)};pfh=10000000;
    for j=1:11
        temp=hang{j};
        p=sum(abs(org(180,:)-temp(1,:)));
        if p<pfh
            pfh=p;
            cn=j;
        end
    end
    [swxy(i),cn,p]
end

for i=1:3
    org=hang{syxw(i)};pfh=10000000;
    for j=1:11
        temp=hang{j};
        p=sum(abs(org(1,:)-temp(180,:)));
        if p<pfh
            pfh=p;
            cn=j;
        end
    end
    [cn,syxw(i),p]
end

for i=1:5
    org=hang{syxy(i)};pfh=10000000;
    for j=1:11
        temp=hang{j};
        p=sum(abs(org(180,:)-temp(1,:)));
        if p<pfh
             pfh=p;
            cn=j;
        end
    end
     [syxy(i),cn,p]
end  

        
        
        
        