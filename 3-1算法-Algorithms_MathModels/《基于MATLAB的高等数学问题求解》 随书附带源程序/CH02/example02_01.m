web -broswer http://www.ilovematlab.cn/forum-221-1.html
year=input('请输入您需查询的年份：');                     
n=weekday([int2str(year),'-4-30']);            
day=1+(14-n);                                  
fprintf('%d年的母亲节日期：%d-%d-%d\n',year,year,5,day)
