/*****************************************************************
Floyd算法:用于寻找给定的加权图中顶点间最短路径的算法。

intro:
    通过一个图的权值矩阵求出它的每两点间的最短路径矩阵。
    从图的带权邻接矩阵A=[a(i,j)] n×n开始，递归地进行n次更新，即由矩阵D(0)=A，
    按一个公式，构造出矩阵D(1)；又用同样地公式由D(1)构造出D(2)；……；最后又用同样的公式由D(n-1)构造出矩阵D(n)。
    矩阵D(n)的i行j列元素便是i号顶点到j号顶点的最短路径长度，称D(n)为图的距离矩阵，同时还可引入一个后继节点矩阵path来记录两点间的最短路径。

算法描述
　a)　初始化：D[u,v]=A[u,v]
　b)　For k:=1 to n
　　　　For i:=1 to n
　　　　　For j:=1 to n
　　　　　　If D[i,j]>D[i,k]+D[k,j] Then
　　　　　　　D[i,j]:=D[i,k]+D[k,j];
　c)　算法结束：D即为所有点对的最短路径矩阵

算法过程
    把图用邻接距阵G表示出来，如果从Vi到Vj有路可达，则G[i,j]=d，d表示该路的长度；否则G[i,j]=空值。
    定义一个距阵D用来记录所插入点的信息，D[i,j]表示从Vi到Vj需要经过的点，初始化D[i,j]=j。
    把各个顶点插入图中，比较插点后的距离与原来的距离，G[i,j] = min( G[i,j], G[i,k]+G[k,j] )，如果G[i,j]的值变小，则D[i,j]=k。
    在G中包含有两点之间最短道路的信息，而在D中则包含了最短通路径的信息。
    比如，要寻找从V5到V1的路径。根据D，假如D(5,1)=3则说明从V5到V1经过V3，路径为{V5,V3,V1}，如果D(5,3)=3，说明V5与V3直接相连，如果D(3,1)=1，说明V3与V1直接相连。

时间复杂度
    O(n^3)

优缺点分析
    Floyd算法适用于APSP(All Pairs Shortest Paths)，稠密图效果最佳，边权可正可负。此算法简单有效，由于三重循环结构紧凑，对于稠密图，效率要高于执行|V|次Dijkstra算法。
    优点：容易理解，可以算出任意两个节点之间的最短距离，代码编写简单；
    缺点：时间复杂度比较高，不适合计算大量数据。

算法实现
**********************************************************************************/
#include <fstream>
#include <cstring>
#define Maxm 501

using namespace std;

ifstream fin("APSP.in");
ofstream fout("APSP.out");

int p, q, k, m;
int Vertex, Line[Maxm];
int Path[Maxm][Maxm], Map[Maxm][Maxm], Dist[Maxm][Maxm];

void Root(int p, int q)
{
    if (Path[p][q] > 0)
    {
        Root(p, Path[p][q]);
        Root(Path[p][q], q);
    }
    else
    {
        Line[k] = q;
        k++;
    }
}
//无法连通的两个点之间距离为0
int main()
{
    memset(Path, 0, sizeof(Path));
    memset(Map, 0, sizeof(Map));
    memset(Dist, 0, sizeof(Dist));

    fin >> Vertex;
    for (p = 1; p <= Vertex; p++)
        for (q = 1; q <= Vertex; q++)
        {
            fin >> Map[p][q];
            Dist[p][q] = Map[p][q];
        }
    for (k = 1; k <= Vertex; k++)
        for (p = 1; p <= Vertex; p++)
            if (Dist[p][k] > 0)
                for (q = 1; q <= Vertex; q++)
                    if (Dist[k][q] > 0)
                    {
                        if (((Dist[p][q] > Dist[p][k] + Dist[k][q]) || (Dist[p][q] == 0)) && (p != q))
                        {
                            Dist[p][q] = Dist[p][k] + Dist[k][q];
                            Path[p][q] = k;
                        }
                    }

    for (p = 1; p <= Vertex; p++)
    {
        for (q = p + 1; q <= Vertex; q++)
        {
            fout << "\n==========================\n";
            fout << "Source:" << p << '\n'
                 << "Target " << q << '\n';
            fout << "Distance:" << Dist[p][q] << '\n';
            fout << "Path:" << p;
            k = 2;
            Root(p, q);
            for (m = 2; m <= k - 1; m++)
                fout << "-->" << Line[m];
            fout << '\n';
            fout << "==========================\n";
        }
    }
    fin.close();
    fout.close();
    return 0;
}
