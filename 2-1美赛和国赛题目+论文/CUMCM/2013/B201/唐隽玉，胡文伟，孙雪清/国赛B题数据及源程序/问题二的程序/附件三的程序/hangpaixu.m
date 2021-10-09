AA=[168	100	76	62	142	30	41	23	147	191	50	179	120	86	195	26	1	87	18
125	13	182	109	197	16	184	110	187	66	106	150	21	173	157	181	204	139	145
61	19	78	67	69	99	162	96	131	79	63	116	163	72	6	177	20	52	36
94	34	84	183	90	47	121	42	124	144	77	112	149	97	136	164	127	58	43
7	208	138	158	126	68	175	45	174	0	137	53	56	93	153	70	166	32	196
38	148	46	161	24	35	81	189	122	103	130	193	88	167	25	8	9	105	74
14	128	3	159	82	199	135	12	73	160	203	169	134	39	31	51	107	115	176
29	64	111	201	5	92	180	48	37	75	55	44	206	10	104	98	172	171	59
89	146	102	154	114	40	151	207	155	140	185	108	117	4	101	113	194	119	123
49	54	65	143	186	2	57	192	178	118	190	95	11	22	129	28	91	188	141
71	156	83	132	200	17	80	33	202	198	15	133	170	205	85	152	165	27	60
];


for i=1:11
    tp1=[];
    for j=1:19
        tt=AA(i,j);
        tp1=[tp1 a{tt}];
    end
    hang{i}=tp1;
end
%for i=1:11
 %   tp1=[];
 %   for j=1:19
 %       tp1=[tp1 a{AA(i,j)}];
%    end
 %   hang{i}=tp1;
%end
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

        
        
        
        