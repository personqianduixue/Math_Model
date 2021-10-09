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

int xx=7100,yy=3200;
PVrect data[24];
int min=310;
int choice=13;
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
						result_1=(data[i].value*data[i].x*data[i].y)/1000000+RectFun(x-data[i].x,data[i].y)+RectFun(x,y-data[i].y);
						result_2=(data[i].value*data[i].x*data[i].y)/1000000+RectFun(x-data[i].x,y)+RectFun(data[i].x,y-data[i].y);
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
						result_1=(data[i].value*data[i].x*data[i].y)/1000000+RectFun(x-data[i].y,data[i].x)+RectFun(x,y-data[i].x);
						result_2=(data[i].value*data[i].x*data[i].y)/1000000+RectFun(x-data[i].y,y)+RectFun(data[i].y,y-data[i].x);
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
	data[0].type="C1";		data[0].x=1300;		data[0].y=1100;		data[0].value=608.0576;
	data[1].type="C5";		data[1].x=1400;		data[1].y=1100;		data[1].value=564.5285;
	data[2].type="C3";		data[2].x=1414;		data[2].y=1114;		data[2].value=552.5914;
	data[3].type="C2";		data[3].x=1321;		data[3].y=711;		data[3].value=536.6008;
	data[4].type="C4";		data[4].x=1400;		data[4].y=1100;		data[4].value=507.9406;
	data[5].type="C11";		data[5].x=1645;		data[5].y=712;		data[5].value=371.5829;
	data[6].type="C10";		data[6].x=818;		data[6].y=355;		data[6].value=359.2386;
	data[7].type="C8";		data[7].x=615;		data[7].y=355;		data[7].value=318.2531;
	data[8].type="C9";		data[8].x=920;		data[8].y=355;		data[8].value=317.7751;
	data[9].type="C7";		data[9].x=615;		data[9].y=180;		data[9].value=316.6456;
	data[10].type="C6";		data[10].x=310;		data[10].y=355;		data[10].value=315.6212;
	data[11].type="B3";		data[11].x=1482;		data[11].y=992;		data[11].value=176.8102;
	data[12].type="B5";		data[12].x=1956;		data[12].y=992;		data[12].value=158.5532;
	
	max=RectFun(xx,yy);
	printf("%lf\n",max);
	for(i=0;i<choice;i++)
	{
		if(PVrect_result[i]>0)
		printf("%s\n",data[i].type);
	}
	return 0;
}