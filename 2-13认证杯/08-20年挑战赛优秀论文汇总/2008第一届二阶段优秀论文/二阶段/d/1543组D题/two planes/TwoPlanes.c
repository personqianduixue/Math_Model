#include<stdio.h>
#include<stdlib.h>
#include<conio.h>
#include<time.h>

int a[9][9]={0},b[9][9]={0},c[9][9]={0},d[9][9]={0};
int CS=0,HS=0,HH=0;

void main()
{
	void CREAT_HC();
	void SHOW();
	int FIGHT();
	int kz,k;
	char c;

	while(1)
	{
		CREAT_HC();
		kz=FIGHT();
		SHOW();
		printf("---------------------------------------------------\n");
		if(kz==0)
		{printf("电脑得分!\n"); CS++;}
		else
		{printf("玩家得分!\n"); HS++;}
		if(CS>=10||HS>=10) break;
		printf("电脑:玩家=%d:%d\n",CS,HS);
		printf("---------------------------------------------------\n");
		printf("继续吗?(Y/N)");
		do
		{
			c=getche(); k=1;
			if(c=='y'||c=='Y') k=1;
			else if (c=='n'||c=='N') exit(0);
			else {printf("您的选择有误，请重新输入!\n"); k=0;}
		}while(k==0);
	}
	printf("电脑:玩家=%d:%d\n",CS,HS);
	printf("---------------------------------------------------\n");
	if(CS>=10) printf("电脑获胜!\n");
	else printf("玩家获胜\n");
	c=getch();
}

void CL(int x[][9])//清空数组
{
	int i,j;
	for(i=0;i<9;i++)
		for(j=0;j<9;j++)
			x[j][i]=0;
}

void CREAT(int a[][9])//随机飞机生成
{
	int x,y,k;
	srand(time(NULL));
	k=rand()%2;
	if(k==0)//纵向分
	{
		k=rand()%2;
		if(k==0)//飞机1-纵向分-机翼横向
		{
			x=2;
			y=rand()%9;
			a[x][y]=2;
			if(y<3)
			{
				a[x-2][y+1]=a[x-1][y+1]=a[x][y+1]=a[x+1][y+1]=a[x+2][y+1]=1;
				a[x][y+2]=a[x-1][y+3]=a[x][y+3]=a[x+1][y+3]=1;
			}
			else if(y>5)
			{
				a[x-2][y-1]=a[x-1][y-1]=a[x][y-1]=a[x+1][y-1]=a[x+2][y-1]=1;
				a[x][y-2]=a[x-1][y-3]=a[x][y-3]=a[x+1][y-3]=1;
			}
			else
			{
				k=rand()%2;
				if(k==0)
				{
					a[x-2][y+1]=a[x-1][y+1]=a[x][y+1]=a[x+1][y+1]=a[x+2][y+1]=1;
					a[x][y+2]=a[x-1][y+3]=a[x][y+3]=a[x+1][y+3]=1;
				}
				else
				{
					a[x-2][y-1]=a[x-1][y-1]=a[x][y-1]=a[x+1][y-1]=a[x+2][y-1]=1;
					a[x][y-2]=a[x-1][y-3]=a[x][y-3]=a[x+1][y-3]=1;
				}
			}
		}
		else//飞机1-纵向分-机翼纵向
		{
			while(1)
			{
				x=rand()%5;
				if(x!=2) break;
			}
			y=rand()%5+2;
			a[x][y]=2;
			if(x==0||x==1)
			{
				a[x+1][y-2]=a[x+1][y-1]=a[x+1][y]=a[x+1][y+1]=a[x+1][y+2]=1;
				a[x+2][y]=a[x+3][y-1]=a[x+3][y]=a[x+3][y+1]=1;
			}
			if(x==3||x==4)
			{
				a[x-1][y-2]=a[x-1][y-1]=a[x-1][y]=a[x-1][y+1]=a[x-1][y+2]=1;
				a[x-2][y]=a[x-3][y-1]=a[x-3][y]=a[x-3][y+1]=1;
			}
		}

		k=rand()%2;
		if(k==0)//飞机2-纵向分-机翼横向
		{
			x=6;
			while(1)
			{
				y=rand()%9;
				if(a[4][y+1]==0&&a[4][y-1]==0) break;
			}
			a[x][y]=2;
			if(y<3)
			{
				a[x-2][y+1]=a[x-1][y+1]=a[x][y+1]=a[x+1][y+1]=a[x+2][y+1]=1;
				a[x][y+2]=a[x-1][y+3]=a[x][y+3]=a[x+1][y+3]=1;
			}
			else if(y>5)
			{
				a[x-2][y-1]=a[x-1][y-1]=a[x][y-1]=a[x+1][y-1]=a[x+2][y-1]=1;
				a[x][y-2]=a[x-1][y-3]=a[x][y-3]=a[x+1][y-3]=1;
			}
			else
			{
				k=rand()%2;
				if(k==0)
				{
					a[x-2][y+1]=a[x-1][y+1]=a[x][y+1]=a[x+1][y+1]=a[x+2][y+1]=1;
					a[x][y+2]=a[x-1][y+3]=a[x][y+3]=a[x+1][y+3]=1;
				}
				else
				{
					a[x-2][y-1]=a[x-1][y-1]=a[x][y-1]=a[x+1][y-1]=a[x+2][y-1]=1;
					a[x][y-2]=a[x-1][y-3]=a[x][y-3]=a[x+1][y-3]=1;
				}
			}
		}
		else//飞机2-纵向分-机翼纵向
		{
			y=rand()%5+2;
			while(1)
			{
				x=rand()%5+4;
				if(x==4)
				{
					while(1)
					{
						y=rand()%5+2;
						if(a[x][y]==0) break;
					}
				}
				if(x==7)
				{
					while(1)
					{
						y=rand()%5+2;
						if(a[4][y-1]==0&&a[4][y]==0&&a[4][y+1]==0) break;
					}
				}
				if(x!=6) break;
			}
			a[x][y]=2;
			if(x==4||x==5)
			{
				a[x+1][y-2]=a[x+1][y-1]=a[x+1][y]=a[x+1][y+1]=a[x+1][y+2]=1;
				a[x+2][y]=a[x+3][y-1]=a[x+3][y]=a[x+3][y+1]=1;
			}
			if(x==7||x==8)
			{
				a[x-1][y-2]=a[x-1][y-1]=a[x-1][y]=a[x-1][y+1]=a[x-1][y+2]=1;
				a[x-2][y]=a[x-3][y-1]=a[x-3][y]=a[x-3][y+1]=1;
			}
		}
	}

	else//横向分
	{
		k=rand()%2;
		if(k==0)//飞机1-横向分-机翼纵向
		{
			y=2;
			x=rand()%9;
			a[x][y]=2;
			if(x<3)
			{
				a[x+1][y-2]=a[x+1][y-1]=a[x+1][y]=a[x+1][y+1]=a[x+1][y+2]=1;
				a[x+2][y]=a[x+3][y-1]=a[x+3][y]=a[x+3][y+1]=1;
			}
			else if(x>5)
			{
				a[x-1][y-2]=a[x-1][y-1]=a[x-1][y]=a[x-1][y+1]=a[x-1][y+2]=1;
				a[x-2][y]=a[x-3][y-1]=a[x-3][y]=a[x-3][y+1]=1;
			}
			else
			{
				k=rand()%2;
				if(k==0)
				{
					a[x+1][y-2]=a[x+1][y-1]=a[x+1][y]=a[x+1][y+1]=a[x+1][y+2]=1;
					a[x+2][y]=a[x+3][y-1]=a[x+3][y]=a[x+3][y+1]=1;
				}
				else
				{
					a[x-1][y-2]=a[x-1][y-1]=a[x-1][y]=a[x-1][y+1]=a[x-1][y+2]=1;
					a[x-2][y]=a[x-3][y-1]=a[x-3][y]=a[x-3][y+1]=1;
				}
			}
		}
		else//飞机1-横向分-机翼横向
		{
			while(1)
			{
				y=rand()%5;
				if(y!=2) break;
			}
			x=rand()%5+2;
			a[x][y]=2;
			if(y==0||y==1)
			{
				a[x-2][y+1]=a[x-1][y+1]=a[x][y+1]=a[x+1][y+1]=a[x+2][y+1]=1;
				a[x][y+2]=a[x-1][y+3]=a[x][y+3]=a[x+1][y+3]=1;
			}
			if(y==3||y==4)
			{
				a[x-2][y-1]=a[x-1][y-1]=a[x][y-1]=a[x+1][y-1]=a[x+2][y-1]=1;
				a[x][y-2]=a[x-1][y-3]=a[x][y-3]=a[x+1][y-3]=1;
			}
		}

		k=rand()%2;
		if(k==0)//飞机2-横向分-机翼纵向
		{
			y=6;
			while(1)
			{
				x=rand()%9;
				if(a[x+1][4]==0&&a[x-1][4]==0) break;
			}
			a[x][y]=2;
			if(x<3)
			{
				a[x+1][y-2]=a[x+1][y-1]=a[x+1][y]=a[x+1][y+1]=a[x+1][y+2]=1;
				a[x+2][y]=a[x+3][y-1]=a[x+3][y]=a[x+3][y+1]=1;
			}
			else if(x>5)
			{
				a[x-1][y-2]=a[x-1][y-1]=a[x-1][y]=a[x-1][y+1]=a[x-1][y+2]=1;
				a[x-2][y]=a[x-3][y-1]=a[x-3][y]=a[x-3][y+1]=1;
			}
			else
			{
				k=rand()%2;
				if(k==0)
				{
					a[x+1][y-2]=a[x+1][y-1]=a[x+1][y]=a[x+1][y+1]=a[x+1][y+2]=1;
					a[x+2][y]=a[x+3][y-1]=a[x+3][y]=a[x+3][y+1]=1;
				}
				else
				{
					a[x-1][y-2]=a[x-1][y-1]=a[x-1][y]=a[x-1][y+1]=a[x-1][y+2]=1;
					a[x-2][y]=a[x-3][y-1]=a[x-3][y]=a[x-3][y+1]=1;
				}
			}
		}
		else//飞机2-横向分-机翼横向
		{
			x=rand()%5+2;
			while(1)
			{
				y=rand()%5+4;
				if(y==4)
				{
					while(1)
					{
						x=rand()%5+2;
						if(a[x][y]==0) break;
					}
				}
				if(y==7)
				{
					while(1)
					{
						x=rand()%5+2;
						if(a[x-1][4]==0&&a[x][4]==0&&a[x+1][4]==0) break;
					}
				}
				if(y!=6) break;
			}
			a[x][y]=2;
			if(y==4||y==5)
			{
				a[x-2][y+1]=a[x-1][y+1]=a[x][y+1]=a[x+1][y+1]=a[x+2][y+1]=1;
				a[x][y+2]=a[x-1][y+3]=a[x][y+3]=a[x+1][y+3]=1;
			}
			if(y==7||y==8)
			{
				a[x-2][y-1]=a[x-1][y-1]=a[x][y-1]=a[x+1][y-1]=a[x+2][y-1]=1;
				a[x][y-2]=a[x-1][y-3]=a[x][y-3]=a[x+1][y-3]=1;
			}
		}
	}
}

void CREAT_HC()//产生玩家和电脑的飞机
{
	int i,j,k;
	char ch;

bb:	system("cls");
	CL(a); CREAT(a);
	for(i=0;i<9;i++)
	{
		for(j=0;j<9;j++)
			printf("%d ",a[j][i]);
		printf("\n");
	}
	printf("0代表空格，1代表机身，2代表机头\n");
	printf("确定要这一对吗?(Y/N)");
	do
	{
		ch=getche(); k=1;
		if(ch=='y'||ch=='Y') k=1;
		else if (ch=='n'||ch=='N') {goto bb;}
		else {printf("您的选择有误，请重新输入!\n"); k=0;}
	}while(k==0);

	CL(b); CREAT(b);
	CL(c); CL(d);
}

void SHOW()
{
	int i,j;
	system("cls");
	printf("\t飞机对战游戏(19局10胜)\n");
	printf("---------------------------------------------------\n");
	printf("Y↓\t玩家的飞机：\t\t电脑的飞机：\n");
	for(i=0;i<9;i++)
	{
		printf("%d\t",i);
		for(j=0;j<9;j++)
		{
			printf("%d ",c[j][i]);
		}
		printf("\t");
		for(j=0;j<9;j++)
		{
			printf("%d ",d[j][i]);
		}
		printf("\n");
	}
	printf("---------------------------------------------------\n");
	printf("X→\t0 1 2 3 4 5 6 7 8\t0 1 2 3 4 5 6 7 8\n");
	printf("----------------------------------------------------------------------------\n");
	printf("0代表没有打过的格子，1代表打过但没有命中的格子，2代表命中机身，3代表命中机头\n");
	printf("横坐标正方向从左到右，纵坐标正方向从上到下，依次为0～8\n");
	printf("----------------------------------------------------------------------------\n");
}

int BEAT(int a[][9],int b[][9],int x,int y)//打击函数
{
	if(b[x][y]==2||b[x][y]==3) return 9;//判断是否已经打击过
	if(a[x][y]==0)
	{
		b[x][y]=1;
		return 0;
	}
	else if(a[x][y]==1)
	{
		b[x][y]=2;
		return 1;
	}
	else
	{
		b[x][y]=3;
		return 2;
	}
}

int ATTACK()//玩家进攻
{
	int x,y;
	SHOW();
	printf("要打的坐标(中间用空格隔开)：");
	scanf("%d %d",&x,&y);
	return(BEAT(b,d,x,y));
}

int FIGHT()//对战过程
{
	int F_ONE(int,int);
	int k,t,i,x,y,n;
	int xo[5]={2,2,6,6,4};
	int yo[5]={2,6,6,2,4};
	srand(time(NULL));
	for(i=0;i<5;i++)
	{
		k=BEAT(a,c,xo[i],yo[i]); if(k==2) goto pp;
		if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}
		if(k==1) break;
	}
	n=i;
	k=F_ONE(xo[i],yo[i]);
	if(k==1) return 1;
	else if(k==0)
	{
pp:		t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}
		for(i=n+1;i<5;i++)
		{
			k=BEAT(a,c,xo[i],yo[i]); if(k==2) return 0;
			if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}
			if(k==1) {n=9;x=xo[i];y=yo[i];break;}
		}
		while(n!=9)
		{
			x=rand()%9;
			y=rand()%9;
			k=BEAT(a,c,x,y); if(k==2) return 0;
			if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}
			if(k==1) break;
		}
		k=F_ONE(x,y);
		if(k==1) return 1;
		else if(k==0) return 0;
	}
	t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}
	while(1)
	{
		x=rand()%9;
		y=rand()%9;
		k=BEAT(a,c,x,y); if(k==2) return 0;
		if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}
	}
}

int F_ONE(int p,int q)//一架飞机的策略
{
	int k,t;
	int o[4],x[9]={p},y[9]={q};

	k=BEAT(a,c,x[0],y[0]-2); if(k==2) return 0;
	if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}
	if(k==1) {x[1]=x[0]; y[1]=y[0]-2; goto cc;}
	k=BEAT(a,c,x[0],y[0]+2); if(k==2) return 0;
	if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}
	if(k==1) {x[1]=x[0]; y[1]=y[0]+2; goto cc;}
	k=BEAT(a,c,x[0]-2,y[0]); if(k==2) return 0;
	if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}
	if(k==1) {x[1]=x[0]-2; y[1]=y[0]; goto cc;}
	k=BEAT(a,c,x[0]+2,y[0]); if(k==2) return 0;
	if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}
	x[1]=x[0]-2; y[1]=y[0];
cc:	if(x[1]==x[0])
	{
		x[2]=x[3]=x[0];
		x[4]=x[0]-1; x[5]=x[0]+1;
		if(y[1]>y[0])
		{y[2]=y[0]-1; y[3]=y[1]+1;}
		else
		{y[2]=y[1]-1; y[3]=y[0]+1;}
		if(y[2]<0)
		{k=0; goto c1;}
		if(y[3]>8)
		{y[3]=y[2]; k=0; goto c1;}
	}
	else
	{
		y[2]=y[3]=y[0];
		y[4]=y[0]-1; y[5]=y[0]+1;
		if(x[1]>x[0])
		{x[2]=x[0]-1; x[3]=x[1]+1;}
		else
		{x[2]=x[1]-1; x[3]=x[0]+1;}
		if(x[2]<0)
		{k=0; goto c1;}
		if(x[3]>8)
		{x[3]=x[2]; k=0; goto c1;}
	}
	k=BEAT(a,c,x[2],y[2]); if(k==2) return 0;
	if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}
c1:	o[0]=k;
	k=BEAT(a,c,x[3],y[3]); if(k==2) return 0;
	if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}
	o[1]=k;
	if(o[0]==1&&o[1]==1)
	{
		if(x[1]==x[0])
			y[4]=y[5]=(y[0]+y[1])/2;
		else
			x[4]=x[5]=(x[0]+x[1])/2;

		k=BEAT(a,c,x[4],y[4]); if(k==2) return 0;
		if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}
		k=BEAT(a,c,x[5],y[5]); if(k==2) return 0;
	}
	else if(o[0]==1||o[1]==1)
	{
		if(x[1]==x[0])
			y[4]=y[5]=y[0];
		else
			x[4]=x[5]=x[0];

		k=BEAT(a,c,x[4],y[4]); if(k==2) return 0;
		if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}
		k=BEAT(a,c,x[5],y[5]); if(k==2) return 0;
	}
	if(o[0]==0&&o[1]==0)
	{
		if(x[1]==x[0])
		{
			y[4]=y[5]=(y[0]+y[1])/2;
			x[4]=x[0]-3; x[5]=x[0]+3;
			if(x[4]<0) goto c2;
			if(x[5]>8)
			{x[5]=x[4]; goto c2;}
		}
		else
		{
			x[4]=x[5]=(x[0]+x[1])/2;
			y[4]=y[0]-3; y[4]=y[0]+3;
			if(y[4]<0) goto c2;
			if(y[5]>8)
			{y[5]=y[4]; goto c2;}
		}
		
		k=BEAT(a,c,x[4],y[4]); if(k==2) return 0;
		if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}
c2:		k=BEAT(a,c,x[5],y[5]); if(k==2) return 0;
		if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}

		if(x[1]==x[0])
		{y[6]=(y[0]+y[1])/2; x[6]=x[0]-1;}
		else
		{x[6]=(x[0]+x[1])/2; y[6]=y[0]-1;}
		k=BEAT(a,c,x[6],y[6]);
		if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}

		if(k==1)
		{
			if(x[1]==x[0])
			{x[7]=x[8]=x[6]; y[7]=y[6]-2; y[8]=y[6]+2;}
			else
			{y[7]=y[8]=y[6]; x[7]=x[6]-2; x[8]=x[6]+2;}
		}
		else
		{
			if(x[1]==x[0])
			{
				x[7]=x[8]=x[0]+1;
				y[7]=y[6]-2; y[8]=y[6]+2;
				if(y[7]<0) goto c3;
				if(y[8]>8)
				{y[8]=y[7]; goto c3;}
			}
			else
			{
				y[7]=y[8]=y[0]+1;
				x[7]=x[6]-2; x[8]=x[6]+2;
				if(x[7]<0) goto c3;
				if(x[8]>8)
				{x[8]=x[7]; goto c3;}
			}
		}
		k=BEAT(a,c,x[7],y[7]); if(k==2) return 0;
		if(k!=9) {t=ATTACK(); if(t==2){HH++; if(HH==2)return 1;}}
c3:		k=BEAT(a,c,x[8],y[8]); if(k==2) return 0;
	}
	return 9;
}
