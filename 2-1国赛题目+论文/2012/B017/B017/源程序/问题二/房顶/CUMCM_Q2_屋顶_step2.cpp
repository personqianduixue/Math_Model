#include<stdio.h>
#include<math.h>
//根据step1确定各块数量
double max=167004.216113;
//记录各型号电池参数
typedef struct PVrect
{
	char* type;	//产品型号
	int x;	//产品长度
	int y;	//产品宽度
	double value;	//产品权值
}PVrect;
PVrect data[5];
int main()
{
	double sum;
	double temp;
	double min=max;
	int mini;
	int minj;
	int mink;
	int minl;
	int minm;
	data[0].type="B3";		data[0].x=1482;		data[0].y=992;		data[0].value=2049.523;
	data[1].type="A3";		data[1].x=1580;		data[1].y=808;		data[1].value=1884.013;
	data[2].type="C1";		data[2].x=1300;		data[2].y=1100;		data[2].value=1363.692;
	data[3].type="C2";		data[3].x=1321;		data[3].y=711;		data[3].value=1203.591;
	data[4].type="C10";		data[4].x=818;		data[4].y=355;		data[4].value=805.7007;
	int i,j,k,l,m;
	for(i=1;i<=35;i++)
	{
		for(j=1;j<=15;j++)
		{
			for(k=1;k<=20;k++)
			{
				for(l=1;l<=40;l++)
				{
					for(m=10;m<=40;m++)
					{
						sum=i*data[0].x*data[0].y*data[0].value/1000000+j*data[1].x*data[1].y*data[1].value/1000000+k*data[2].x*data[2].y*data[2].value/1000000+l*data[3].x*data[3].y*data[3].value/1000000+m*data[4].x*data[4].y*data[4].value/1000000;
						temp=sum-max;
						if(temp<0)
							temp=-temp;
						else
							continue;
						if(temp<min&&(double(i*data[0].x*data[0].y)/1000000+double(j*data[1].x*data[1].y)/1000000+double(k*data[2].x*data[2].y)/1000000+double(l*data[3].x*data[3].y)/1000000+double(m*data[4].x*data[4].y)/1000000)<=(10.1*8.836-6))
						{
							min=temp;
							mini=i;
							minj=j;
							mink=k;
							minl=l;
							minm=m;
						}
					}
				}
			}
		}
	}
	printf("%s %d\n%s %d\n%s %d\n%s %d\n%s %d\n",data[0].type,mini,data[1].type,minj,data[2].type,mink,data[3].type,minl,data[4].type,minm);
	printf("%lf\n",mini*data[0].x*data[0].y*data[0].value/1000000+minj*data[1].x*data[1].y*data[1].value/1000000+mink*data[2].x*data[2].y*data[2].value/1000000+minl*data[3].x*data[3].y*data[3].value/1000000+minm*data[4].x*data[4].y*data[4].value/1000000);
	printf("%lf\n",double(mini*data[0].x*data[0].y)/1000000+double(minj*data[1].x*data[1].y)/1000000+double(mink*data[2].x*data[2].y)/1000000+double(minl*data[3].x*data[3].y)/1000000+double(minm*data[4].x*data[4].y)/1000000);
	return 0;
}