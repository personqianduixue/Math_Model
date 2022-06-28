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

int xx=930,yy=355;
PVrect data[24];
int min=310;

int PVrect_result[24]={0};

double RectFun(int x,int y)
{
	double result=0;
	double result_1=0,result_2=0;
	int i,j;
	if(x<min||y<min)
	{
		return 0;
	}
	else
	{
		for(i=0;i<=23;i++)
		{
			for(j=0;j<=1;j++)
			{
				if(j==0)
				{	
					if(x>=data[i].x&&y>=data[i].y)
					{
						PVrect_result[i]++;
						result_1=data[i].value+RectFun(x-data[i].x,data[i].y)+RectFun(x,y-data[i].y);
						result_2=data[i].value+RectFun(x-data[i].x,y)+RectFun(data[i].x,y-data[i].y);
						if(result_1>=result_2)
							return result_1;
						else
							return result_2;
					}
				}
				else
				{
					if(x>=data[i].y&&y>=data[i].x)
					{
						PVrect_result[i]++;
						result_1=data[i].value+RectFun(x-data[i].y,data[i].x)+RectFun(x,y-data[i].x);
						result_2=data[i].value+RectFun(x-data[i].y,y)+RectFun(data[i].y,y-data[i].x);
						if(result_1>=result_2)
							return result_1;
						else
							return result_2;
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
	data[0].type="A1";		data[0].x=1580;		data[0].y=808;		data[0].value=24;
	data[1].type="A2";		data[1].x=1956;		data[1].y=991;		data[1].value=23;
	data[2].type="A3";		data[2].x=1580;		data[2].y=808;		data[2].value=22;
	data[3].type="A4";		data[3].x=1651;		data[3].y=992;		data[3].value=21;
	data[4].type="A5";		data[4].x=1650;		data[4].y=991;		data[4].value=20;
	data[5].type="A6";		data[5].x=1956;		data[5].y=991;		data[5].value=19;
	
	data[6].type="B1";		data[6].x=1650;		data[6].y=991;		data[6].value=18;
	data[7].type="B2";		data[7].x=1956;		data[7].y=991;		data[7].value=17;
	data[8].type="B3";		data[8].x=1482;		data[8].y=992;		data[8].value=16;
	data[9].type="B4";		data[9].x=1640;		data[9].y=992;		data[9].value=15;
	data[10].type="B5";		data[10].x=1956;		data[10].y=992;		data[10].value=14;
	data[11].type="B6";		data[11].x=1956;		data[11].y=992;		data[11].value=13;
	data[12].type="B7";		data[12].x=1668;		data[12].y=1000;		data[12].value=12;
	
	data[13].type="C1";		data[13].x=1300;		data[13].y=1100;		data[13].value=11;
	data[14].type="C2";		data[14].x=1321;		data[14].y=711;		data[14].value=10;
	data[15].type="C3";		data[15].x=1414;		data[15].y=1114;		data[15].value=9;
	data[16].type="C4";		data[16].x=1400;		data[16].y=1100;		data[16].value=8;
	data[17].type="C5";		data[17].x=1400;		data[17].y=1100;		data[17].value=7;
	data[18].type="C6";		data[18].x=310;		data[18].y=355;		data[18].value=6;
	data[19].type="C7";		data[19].x=615;		data[19].y=180;		data[19].value=5;
	data[20].type="C8";		data[20].x=615;		data[20].y=355;		data[20].value=4;
	data[21].type="C9";		data[21].x=920;		data[21].y=355;		data[21].value=3;
	data[22].type="C10";		data[22].x=818;		data[22].y=355;		data[22].value=2;
	data[23].type="C11";		data[23].x=1645;		data[23].y=712;		data[23].value=1;
	
	max=RectFun(xx,yy);
	printf("%lf\n",max);
	for(i=0;i<=23;i++)
	{
		if(PVrect_result[i]>0)
		printf("%s\n",data[i].type);
	}
	return 0;
}