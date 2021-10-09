#include <cstdio>
#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;
const int maxn = 60000;
const int maxm = 2000000;
vector<int>in[maxn],out[maxn];
struct Side{
    int u,v;
}side[maxm];
int hh[maxm*2],totEdge,siz;
void getInOut(){
    for(int i = 0;i < totEdge;i ++){
        int u = side[i].u;
        int v = side[i].v;
        in[v].push_back(u);
        out[u].push_back(v);
    }
}
double getSame(vector<int>a,vector<int>b){//calculate the number of same node
    double ans = 0;
    int sa = a.size(),sb = b.size();
    for(int i = 0;i < sa;i ++){
        for(int j = 0;j < sb;j ++){
            ans += (a[i] == b[j]);
        }
    }
    return ans;
}

double getVal(int a,int b){//get the value of edge based on GCN
    double ans = 0;
    ans += getSame(out[a],in[b]);
    ans += (getSame(out[a],out[b]) + getSame(in[a],in[b]))/2.0;
    return ans;
}

struct Edge{
    int a,b;
    double key;
}edge[maxm];
int sumDU(Edge a){//get the value of edge based on PA
    return out[a.a].size() * in[a.b].size();
}
bool cmp(Edge a,Edge b){
    return a.key < b.key
    ||(a.key == b.key && sumDU(a) < sumDU(b));
}
bool cmp1(Edge a,Edge b){
    return sumDU(a) < sumDU(b)
    ||(sumDU(a) == sumDU(b) && getVal(a.a,a.b) < getVal(a.a,a.b));
}
bool cmp2(Edge a,Edge b){
    return sumDU(a) < sumDU(b);
}
int main(){
    freopen("SD.txt","r",stdin);
    freopen("SDans.csv","w",stdout);
    char s[100];cin>>s;
    int a,b;
    //buld graph and idiscretization
    totEdge = 0;
    while(~scanf("%d,%d",&a,&b)){//if(totEdge < 10)cout<<a<<' '<<b<<endl;
        side[totEdge] = (Side){a,b};
        hh[totEdge*2] = a;
        hh[totEdge*2+1] = b;
        totEdge ++;
    }
    sort(hh,hh+totEdge*2);
    siz = unique(hh,hh+totEdge*2) - hh;
    for(int i = 0;i < totEdge;i ++){
        side[i].u = lower_bound(hh,hh+siz,side[i].u) - hh + 1;
        side[i].v = lower_bound(hh,hh+siz,side[i].v) - hh + 1;
    }
    //buld graph and idiscretization

    getInOut();
    int nowEdge = 0;
    for(int i = 1;i <= siz;i ++){
        int nn = out[i].size();
        for(int j = 0;j < nn;j ++){
            //edge[nowEdge ++] = (Edge){i,out[i][j],getVal(i,out[i][j])};//if need GCN
            edge[nowEdge ++] = (Edge){i,out[i][j],0};//if don't GCN
        }
    }
    //sort(edge,edge + nowEdge,cmp);//first compare GCN then compare PA
    //sort(edge,edge + nowEdge,cmp1);//first compare PA then compare GCN
    sort(edge,edge + nowEdge,cmp2);//compare PA
    puts("node1,node2");
    int need = 71732;//the number of error edges
    for(int i = 0;i < need;i ++){
        cout<<hh[edge[i].a-1]<<','<<hh[edge[i].b-1]<<','<<sumDU(edge[i])<<endl;
    }
    return 0;
}
