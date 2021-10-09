#include <cstdio>
#include <cstring>
#include <algorithm>
#include <iostream>
#include <vector>
#include <queue>
#include <stack>
using namespace std;
const int MAXM = 1E7;
const int MAXN = 60000;
struct Side{
    int u,v;
}side[MAXM];
vector<int>vv[MAXN];
int siz,totEdge;//the number of nodes,the number of edges
int hh[MAXM];
bool vis[MAXN];
void ppGraph(){//print graph
    for(int i = 1;i <= siz;i ++){
        cout<<i<<':';
        for(int j = 0;j < vv[i].size();j ++)
            cout<<vv[i][j]<<' ';
        cout<<endl;
    }
    cout<<endl;
}

void ppDiscretization(){//print the result of discretization
    for(int i = 0;i < totEdge;i ++){
        cout<<side[i].u<<' '<<side[i].v<<endl;
    }
}

void buildGraph(bool flag){//if flag is 0,graph is undirected
    for(int i = 0;i < totEdge;i ++){
        vv[side[i].u].push_back(side[i].v);
        if(flag == 0)vv[side[i].v].push_back(side[i].u);//wu xiang tu
    }
}

void getNC(){//undirected graph connected componet
    memset(vis,0,sizeof(vis));
    int totT = 0,maxNum = 0;
    queue<int>q;
    for(int i = 1;i <= siz;i ++){
        if(vis[i] == 0){
            vis[i] = 1;
            q.push(i);
            totT ++;
            int Tnum = 1;
            while(!q.empty()){
                int now = q.front();q.pop();
                int nn = vv[now].size();
                for(int j = 0;j < nn;j ++){
                    if(vis[vv[now][j]])continue;
                    Tnum ++;
                    q.push(vv[now][j]);
                    vis[vv[now][j]] = 1;
                }
            }
            maxNum = max(maxNum,Tnum);
        }
    }
    cout<<"the number of node of the max Connected component :"<<maxNum<<"the number of Connected component :"<<totT<<endl;
}

void getE(){//global efficiency
    double totDis = 0.0;
    for(int i = 1;i <= siz;i ++){
        memset(vis,0,sizeof(vis));
        queue<pair<int,int> >q;
        q.push(make_pair(i,0));
        vis[i] = 1;
        while(!q.empty()){
            pair<int,int> tmp = q.front();q.pop();
            if(tmp.second)totDis += 1.0/tmp.second;
            int now = tmp.first,nn = vv[now].size();
            for(int j = 0;j < nn;j ++){
                int xx = vv[now][j];
                if(vis[xx])continue;
                q.push(make_pair(xx,tmp.second+1));
                vis[xx] = 1;
            }
        }
    }
    cout<<"the average length of Shortest path of all nodes "<<totDis/siz/(siz-1)<<endl;
}

bool have(int b,int a){//judge whether have edge b->a or not
    int nn = vv[b].size();
    for(int i = 0;i < nn;i ++){
        if(vv[b][i] == a)return 1;
    }
    return false;
}

void getC(){//two kind of clustering coefficient
    //ppGraph();
    double C1 = 0,C2 = 0;
    long long totLian = 0;
    long long totTri = 0;
    for(int i = 1;i <= siz;i ++){
        int nn = vv[i].size();
        if(nn <= 1)continue;
        int tmpTri = 0;
        for(int one = 0;one < nn;one ++){
            for(int two = one + 1;two < nn;two ++){
                tmpTri += have(vv[i][two],vv[i][one]);
            }
        }
        double tmpC1 = (double)tmpTri*2/nn/(nn-1);
        C1 += tmpC1;

        totTri += tmpTri;
        totLian += nn*(nn-1)/2;
    }
    C1 /= siz;
    C2 = (double)totTri/totLian;
    cout<<"average Clustering coefficient of all nodes :"<<C1<<' '<<C2<<endl;
}

void getZ(){//average degree of nodes
    cout<<"average degree of nodes"<<(double)totEdge/siz<<endl;
}

//strongly connected component in directed graph
int t,dfn[MAXN],low[MAXN],sum;
int gNum[MAXN];
stack<int>s;
void dfs(int u){
    dfn[u] = low[u] = ++t;
    s.push(u);
    int nn = vv[u].size();
    for(int i = 0;i < nn;i ++){
        int v = vv[u][i];
        if(!dfn[v])dfs(v);
        if(dfn[v] != -1)low[u] = min(low[u],low[v]);
    }
    if(low[u] == dfn[u]){
        int v;
        do {
            v = s.top();s.pop();
            dfn[v] = -1;
            low[v] = sum;
            gNum[sum] ++;
        }while(v != u);
        sum ++;
    }
}
void getG(){
    t = sum = 0;
    for(int i = 1;i <= siz;i ++){
        if(!dfn[i])dfs(i);
    }
    int maxNum = 0;
    for(int i = 0;i < sum;i ++){
        maxNum = max(maxNum,gNum[i]);
    }
    cout<<"the number of nodes of the max Strongly connected component :"<<maxNum<<"the number of Strongly connected component"<<sum<<endl;
}
//strongly connected component in directed graph


void getR1(){//reciprocity
    int totm_d = 0;
    for(int i = 1;i <= siz;i ++){
        int nn = vv[i].size();
        for(int j = 0;j < nn;j ++){
            totm_d += have(vv[i][j],i);
        }
    }
    cout<<"the reciprocity is : "<<(double)totm_d/totEdge<<endl;
}

void Undir(){//get undirected graph parameters
    buildGraph(0);
    cout<<"Total Nodes is :"<<siz<<endl;
    getNC();
    getE();
    getC();
}

void Dir(){//get directed graph parameters
    buildGraph(1);
    cout<<"Total Nodes is :"<<siz<<endl;
    getZ();
    getG();
    getE();
    getR1();

    for(int i = 0;i <= siz;i ++)vv[i].clear();
    buildGraph(0);
    getC();
}

int main(){
    freopen("in.txt","r",stdin);
    //build graph and discretization
    int a,b;
    char s[100];cin>>s;
    totEdge = 0;
    while(~scanf("%d,%d",&a,&b)){
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
        //cout<<side[i].u<<' '<<side[i].v<<endl;
    }
    //ppDiscretization();
    //build graph and discretization

    //Undir();//Get Parameters of Undirected Graph
    Dir();//Get Parameters of Directed Graph
    return 0;
}
