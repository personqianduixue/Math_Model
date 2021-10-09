#include<stdio.h>
#include<math.h>
//记录各型号电池参数
typedef struct PVrect
{
	char* type;	//产品型号
	int x;	//产品长度
	int y;	//产品宽度
	double value;	//产品权值
}PVrect;

int xx=10100,yy=6511.53;
PVrect data[24];
int min=310;
int choice=24;
int PVrect_result[24]={0};

double RectFun(int x,int y)
{
	double result=0;
	double result_1=0,result_2=0;
	int i,j;
	if(x<min||y<min)
	{
		return result;
	}
	else
	{
		for(i=0;i<choice;i++)
		{
			for(j=0;j<=1;j++)
			{
				if(j==0)
				{	
					if(x>=data[i].x&&y>=data[i].y)
					{
						PVrect_result[i]++;
						result_1=data[i].value*data[i].x*data[i].y/1000000+RectFun(x-data[i].x,data[i].y)+RectFun(x,y-data[i].y);
						result_2=data[i].value*data[i].x*data[i].y/1000000+RectFun(x-data[i].x,y)+RectFun(data[i].x,y-data[i].y);
						if(result_1>=result_2)
						{	
							return result_1;
						}
						else
						{
							return result_2;
						}
					}
				}
				else
				{
					if(x>=data[i].y&&y>=data[i].x)
					{
						PVrect_result[i]++;
						result_1=data[i].value*data[i].x*data[i].y/1000000+RectFun(x-data[i].y,data[i].x)+RectFun(x,y-data[i].x);
						result_2=data[i].value*data[i].x*data[i].y/1000000+RectFun(x-data[i].y,y)+RectFun(data[i].y,y-data[i].x);
						if(result_1>=result_2)
						{	
							return result_1;
						}
						else
						{
							return result_2;
						}
					}
				}
			}
		}
	}
} 
int main()
{
	int i;
	double max;
	//各型号电池参数
	
	
	data[0].type="A3";		data[0].x=1580;		data[0].y=808;		data[0].value=1902.904;
	data[1].type="B3";		data[1].x=1482;		data[1].y=992;		data[1].value=1835.303;
	data[2].type="B5";		data[2].x=1956;		data[2].y=992;		data[2].value=1817.046;
	data[3].type="B2";		data[3].x=1956;		data[3].y=991;		data[3].value=1650.181;
	data[4].type="B1";		data[4].x=1650;		data[4].y=991;		data[4].value=1647.149;	
	data[5].type="B6";		data[5].x=1956;		data[5].y=992;		data[5].value=1543.677;
	data[6].type="B7";		data[6].x=1668;		data[6].y=1000;		data[6].value=1523.021;
	data[7].type="B4";		data[7].x=1640;		data[7].y=992;		data[7].value=1509.451;
	data[8].type="A1";		data[8].x=1580;		data[8].y=808;		data[8].value=1306.385;
	data[9].type="A4";		data[9].x=1651;		data[9].y=992;		data[9].value=1282.311;
	data[10].type="A2";		data[10].x=1956;		data[10].y=991;		data[10].value=1272.19;
	data[11].type="C1";		data[11].x=1300;		data[11].y=1100;		data[11].value=1270.905;
	data[12].type="C5";		data[12].x=1400;		data[12].y=1100;		data[12].value=1179.962;
	data[13].type="A5";		data[13].x=1650;		data[13].y=991;		data[13].value=1161.74;
	data[14].type="A6";		data[14].x=1956;		data[14].y=991;		data[14].value=1156.116;
	data[15].type="C3";		data[15].x=1414;		data[15].y=1114;		data[15].value=1154.749;
	data[16].type="C2";		data[16].x=1321;		data[16].y=711;		data[16].value=1121.689;
	data[17].type="C4";		data[17].x=1400;		data[17].y=1100;		data[17].value=1061.736;
	data[18].type="C11";		data[18].x=1645;		data[18].y=712;		data[18].value=776.4981;
	data[19].type="C10";		data[19].x=818;		data[19].y=355;		data[19].value=750.8778;
	data[20].type="C8";		data[20].x=615;		data[20].y=355;		data[20].value=665.3232;
	data[21].type="C9";		data[21].x=920;		data[21].y=355;		data[21].value=664.8453;
	data[22].type="C7";		data[22].x=615;		data[22].y=180;		data[22].value=660.8709;
	data[23].type="C6";		data[23].x=310;		data[23].y=355;		data[23].value=659.8465;
	
	
	
	max=RectFun(xx,yy);
	printf("%lf\n",max);
	for(i=0;i<choice;i++)
	{
		if(PVrect_result[i]>0)
			printf("%s\n",data[i].type);
	}
	return 0;
}