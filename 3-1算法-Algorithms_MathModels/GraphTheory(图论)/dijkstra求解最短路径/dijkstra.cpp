#include <fstream>
#include <cstring>
#define MaxNum 765432100
using namespace std;

ifstream fin("Dijkstra.in");
ofstream fout("Dijkstra.out");

int Map[501][501];
bool is_arrived[501];
int Dist[501], From[501], Stack[501];
int p, q, k, Path, Source, Vertex, Temp, SetCard;

int FindMin()
{
    int p, Temp = 0, Minm = MaxNum;
    for (p = 1; p <= Vertex; p++)
        if ((Dist[p] < Minm) && (!is_arrived[p]))
        {
            Minm = Dist[p];
            Temp = p;
        }
    return Temp;
}
int main()
{
    memset(is_arrived, 0, sizeof(is_arrived));

    fin >> Source >> Vertex;
    for (p = 1; p <= Vertex; p++)
        for (q = 1; q <= Vertex; q++)
        {
            fin >> Map[p][q];
            if (Map[p][q] == 0)
                Map[p][q] = MaxNum;
        }
    for (p = 1; p <= Vertex; p++)
    {
        Dist[p] = Map[Source][p];
        if (Dist[p] != MaxNum)
            From[p] = Source;
        else
            From[p] = p;
    }

    is_arrived[Source] = true;
    SetCard = 1;
    do
    {
        Temp = FindMin();
        if (Temp != 0)
        {
            SetCard = SetCard + 1;
            is_arrived[Temp] = true;
            for (p = 1; p <= Vertex; p++)
                if ((Dist[p] > Dist[Temp] + Map[Temp][p]) && (!is_arrived[p]))
                {
                    Dist[p] = Dist[Temp] + Map[Temp][p];
                    From[p] = Temp;
                }
        }
        else
            break;
    } while (SetCard != Vertex);

    for (p = 1; p <= Vertex; p++)
        if (p != Source)
        {
            fout << "========================\n";
            fout << "Source:" << Source << "\nTarget:" << p << '\n';
            if (Dist[p] == MaxNum)
            {
                fout << "Distance:"
                     << "Infinity\n";
                fout << "Path:No Way!";
            }
            else
            {
                fout << "Distance:" << Dist[p] << '\n';
                k = 1;
                Path = p;
                while (From[Path] != Path)
                {
                    Stack[k] = Path;
                    Path = From[Path];
                    k = k + 1;
                }
                fout << "Path:" << Source;
                for (q = k - 1; q >= 1; q--)
                    fout << "-->" << Stack[q];
            }
            fout << "\n========================\n\n";
        }

    fin.close();
    fout.close();
    return 0;
}