#include<stdio.h>
#include<math.h>
//根据step1确定各块数量
double max=118931.628405;
//记录各型号电池参数
typedef struct PVrect
{
	char* type;	//产品型号
	int x;	//产品长度
	int y;	//产品宽度
	double value;	//产品权值
}PVrect;
PVrect data[2];
int main()
{
	double sum;
	double temp;
	double min=max;
	int mini;
	int minj;
	int mink;
	data[0].type="A3";		data[0].x=1580;		data[0].y=808;		data[0].value=1902.904;
	data[1].type="C10";		data[1].x=818;		data[1].y=355;		data[1].value=750.8778;
	data[2].type="C8";		data[2].x=615;		data[2].y=355;		data[2].value=665.3232;
	int i,j,k;
	for(i=1;i<=50;i++)
	{
		for(j=1;j<=40;j++)
		{
			for(k=1;k<=40;k++)
			{
				sum=i*data[0].x*data[0].y*data[0].value/1000000+j*data[1].x*data[1].y*data[1].value/1000000+k*data[2].x*data[2].y*data[2].value/1000000;
				temp=sum-max;
				if(temp<=0)
					temp=-temp;
				else
					continue;
				if(temp<min&&(double(i*data[0].x*data[0].y)/1000000+double(j*data[1].x*data[1].y)/1000000+double(k*data[2].x*data[2].y)/1000000)<(10.1*6.511))
				{
					min=temp;
					mini=i;
					minj=j;
					mink=k;
				}
			}
		}
	}
	printf("%s %d\n%s %d\n%s %d\n",data[0].type,mini,data[1].type,minj,data[2].type,mink);
	printf("%lf\n",mini*data[0].x*data[0].y*data[0].value/1000000+minj*data[1].x*data[1].y*data[1].value/1000000+mink*data[2].x*data[2].y*data[2].value/1000000);
	printf("%lf\n",double(mini*data[0].x*data[0].y)/1000000+double(minj*data[1].x*data[1].y)/1000000+double(mink*data[2].x*data[2].y)/1000000);
	return 0;
}