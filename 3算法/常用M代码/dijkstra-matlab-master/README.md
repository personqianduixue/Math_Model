# dijkstra-matlab
Dijkstra algorithm implementation in MATLAB

Implementação baseada no algoritmo em Pascal (http://pt.stackoverflow.com/a/85604)

O problema consiste, então, em se achar o caminho mais curto entre duas cidades quaisquer. Este problema foi resolvido por Dijkistra [DIJKISTRA, 1971] e tem uma série de aplicação de questões de otimização.
Além da matriz D das distâncias, considera-se a variável composta unidimensional DA, cuja componente DA[I] representa a distância acumulada em um caminho percorrido desde a origem até a cidade I. Cada uma destas componentes será iniciada com um valor bem grande, por exemplo 10000.

Ainda serão consideradas mais duas variáveis compostas unidimensionais. A primeira, designada Ant, será tal que a sua componente Ant[I] indica qual é a cidade antecedente de I no caminho considerado. A outra ExpA, terá componentes lógicas "expandidas".
Partindo de uma cidade C inicialmente igual a origem, calcula-se a nova distância acumulada (NovaDA) de cada uma das cidades adjacentes a C ainda não expandidas. A nova distância acumulada prevalecerá sobre o valor anterior se lhe for inferior, neste caso ,C será atribuído a componente Ant[I]. Quando terminar a expansão de C, registra-se que ExpA[C] é verdadeiro.
Em seguida, procura-se, dentre as cidades ainda não expandidas, aquelas que têm a menor distancia acumulada. Esta será a nova cidade C, e a sua distancia acumulada é, então, a menor que possa ser conseguida a partir da Origem.
O processo será repetido até que a cidade C seja o Destino ou que não se encontre nenhuma cidade ainda não expandida, cuja distancia acumulada seja inferior a 10000. Neste último caso, isto significa que não existe caminho ligando a Origem ao Destino.
