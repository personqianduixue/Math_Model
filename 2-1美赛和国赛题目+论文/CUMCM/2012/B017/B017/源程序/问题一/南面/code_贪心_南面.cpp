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

int xx=4000,yy=700;
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
	data[0].type="C1";		data[0].x=1300;		data[0].y=1100;		data[0].value=813.046;
	data[1].type="C5";		data[1].x=1400;		data[1].y=1100;		data[1].value=754.8517;	
	data[2].type="B3";		data[2].x=1482;		data[2].y=992;		data[2].value=750.6944;
	data[3].type="C3";		data[3].x=1414;		data[3].y=1114;		data[3].value=738.809;
	data[4].type="B5";		data[4].x=1956;		data[4].y=992;		data[4].value=732.4373;
	data[5].type="C2";		data[5].x=1321;		data[5].y=711;		data[5].value=717.5398;
	data[6].type="C4";		data[6].x=1400;		data[6].y=1100;		data[6].value=679.2022;
	data[7].type="A3";		data[7].x=1580;		data[7].y=808;		data[7].value=633.6807;
	data[8].type="B1";		data[8].x=1650;		data[8].y=991;		data[8].value=546.9297;
	data[9].type="B2";		data[9].x=1956;		data[9].y=991;		data[9].value=537.7442;
	data[10].type="B6";		data[10].x=1956;		data[10].y=992;		data[10].value=512.0092;
	data[11].type="B7";		data[11].x=1668;		data[11].y=1000;		data[11].value=505.6067;
	data[12].type="B4";		data[12].x=1640;		data[12].y=992;		data[12].value=504.9319;
	data[13].type="C11";		data[13].x=1645;		data[13].y=712;		data[13].value=496.8033;
	data[14].type="C10";		data[14].x=818;		data[14].y=355;		data[14].value=480.3533;
	data[15].type="C8";		data[15].x=615;		data[15].y=355;		data[15].value=425.5848;
	data[16].type="C9";		data[16].x=920;		data[16].y=355;		data[16].value=425.1069;
	data[17].type="C7";		data[17].x=615;		data[17].y=180;		data[17].value=423.0976;
	data[18].type="C6";		data[18].x=310;		data[18].y=355;		data[18].value=422.0732;
	data[19].type="A1";		data[19].x=1580;		data[19].y=808;		data[19].value=163.4056;
	data[20].type="A4";		data[20].x=1651;		data[20].y=992;		data[20].value=162.4086;
	data[21].type="A5";		data[21].x=1650;		data[21].y=991;		data[21].value=145.0038;
	data[22].type="A2";		data[22].x=1956;		data[22].y=991;		data[22].value=142.7848;
	data[23].type="A6";		data[23].x=1956;		data[23].y=991;		data[23].value=130.5569;

	
	max=RectFun(xx,yy);
	printf("%lf\n",max);
	for(i=0;i<choice;i++)
	{
		printf("%s %d\n",data[i].type,int(log10(PVrect_result[i]+1)/log10(2)));
	}
	return 0;
}