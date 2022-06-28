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

int xx=10100,yy=8836;
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
	
	data[0].type="B3";		data[0].x=1482;		data[0].y=992;		data[0].value=2049.523;
	data[1].type="B5";		data[1].x=1956;		data[1].y=992;		data[1].value=2031.266;
	data[2].type="A3";		data[2].x=1580;		data[2].y=808;		data[2].value=1884.013;
	data[3].type="B2";		data[3].x=1956;		data[3].y=991;		data[3].value=1869.897;
	data[4].type="B1";		data[4].x=1650;		data[4].y=991;		data[4].value=1864.453;	
	data[5].type="B6";		data[5].x=1956;		data[5].y=992;		data[5].value=1747.441;
	data[6].type="B7";		data[6].x=1668;		data[6].y=1000;		data[6].value=1723.97;
	data[7].type="B4";		data[7].x=1640;		data[7].y=992;		data[7].value=1707.852;
	data[8].type="C1";		data[8].x=1300;		data[8].y=1100;		data[8].value=1363.692;
	data[9].type="A1";		data[9].x=1580;		data[9].y=808;		data[9].value=1289.373;
	data[10].type="C5";		data[10].x=1400;		data[10].y=1100;		data[10].value=1266.112;
	data[11].type="A4";		data[11].x=1651;		data[11].y=992;		data[11].value=1265.643;
	data[12].type="A2";		data[12].x=1956;		data[12].y=991;		data[12].value=1255.38;
	data[13].type="C3";		data[13].x=1414;		data[13].y=1114;		data[13].value=1239.04;
	data[14].type="C2";		data[14].x=1321;		data[14].y=711;		data[14].value=1203.591;
	data[15].type="A5";		data[15].x=1650;		data[15].y=991;		data[15].value=1146.607;
	data[16].type="A6";		data[16].x=1956;		data[16].y=991;		data[16].value=1140.852;
	data[17].type="C4";		data[17].x=1400;		data[17].y=1100;		data[17].value=1139.258;
	data[18].type="C11";		data[18].x=1645;		data[18].y=712;		data[18].value=833.1793;
	data[19].type="C10";		data[19].x=818;		data[19].y=355;		data[19].value=805.7007;
	data[20].type="C8";		data[20].x=615;		data[20].y=355;		data[20].value=713.9072;
	data[21].type="C9";		data[21].x=920;		data[21].y=355;		data[21].value=713.4292;
	data[22].type="C7";		data[22].x=615;		data[22].y=180;		data[22].value=709.0566;
	data[23].type="C6";		data[23].x=310;		data[23].y=355;		data[23].value=708.0322;
	
	
	
	max=RectFun(xx,yy);
	printf("%lf\n",max);
	for(i=0;i<choice;i++)
	{
		if(PVrect_result[i]>0)
			printf("%s\n",data[i].type);
	}
	return 0;
}