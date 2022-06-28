#include<stdio.h>
#include<math.h>
//根据step1确定各块数量
double max=11528.142101;
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
	data[0].type="C1";		data[0].x=1300;		data[0].y=1100;		data[0].value=608.0576;
	data[1].type="C2";		data[1].x=1321;		data[1].y=711;		data[1].value=536.6008;
	data[2].type="C10";		data[2].x=818;		data[2].y=355;		data[2].value=359.2386;
	data[3].type="C8";		data[3].x=615;		data[3].y=355;		data[3].value=318.2531;
	data[4].type="C6";		data[4].x=310;		data[4].y=355;		data[4].value=315.6212;
	int i,j,k,l,m;
	for(i=1;i<=8;i++)
	{
		for(j=1;j<=10;j++)
		{
			for(k=1;k<=20;k++)
			{
				for(l=1;l<=20;l++)
				{
					for(m=3;m<=20;m++)
					{
						sum=i*data[0].x*data[0].y*data[0].value/1000000+j*data[1].x*data[1].y*data[1].value/1000000+k*data[2].x*data[2].y*data[2].value/1000000+l*data[3].x*data[3].y*data[3].value/1000000+m*data[4].x*data[4].y*data[4].value/1000000;
						temp=sum-max;
						if(temp<0)
							temp=-temp;
						else
							continue;
						//由于屋高3200，纵向最多放两块C1或C2，因此面积有损失，这里将总面积修正
						if(temp<min&&(double(i*data[0].x*data[0].y)/1000000+double(j*data[1].x*data[1].y)/1000000+double(k*data[2].x*data[2].y)/1000000+double(l*data[3].x*data[3].y)/1000000+double(m*data[4].x*data[4].y)/1000000)<=(22.72-0.289*1.321*3-0.131*5*0.355-0.123*3.2))
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
	printf("%s %d\n%s %d\n%s %d\n%s %d\n%s %d\n",data[0].type,mini,data[1].type,minj,data[2].type,mink,data[3].type,minl,data[3].type,minm);
	printf("%lf\n",mini*data[0].x*data[0].y*data[0].value/1000000+minj*data[1].x*data[1].y*data[1].value/1000000+mink*data[2].x*data[2].y*data[2].value/1000000+minl*data[3].x*data[3].y*data[3].value/1000000+minm*data[4].x*data[4].y*data[4].value/1000000);
	printf("%lf\n",double(mini*data[0].x*data[0].y)/1000000+double(minj*data[1].x*data[1].y)/1000000+double(mink*data[2].x*data[2].y)/1000000+double(minl*data[3].x*data[3].y)/1000000+double(minm*data[4].x*data[4].y)/1000000);
	return 0;
}