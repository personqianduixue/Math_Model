function dijkstra(N,D,Origem,Destino)
   %任意两顶点间的最短路径
    % N -> 总顶点个数
    % D -> Matriz das dist鈔cias
    % DA -> Matriz de dist鈔cia acumulada
    % Ant -> Cidade anterior
    % ExpA -> Cidades expandidas
    % Origem -> 起始点
    % Destino -> 终点
    % C -> Cidade

    DA = zeros();
    Ant = [];
    ExpA = [];
    C = Origem;

    for i = 1:N
        ExpA(i) = 0;
        DA(i) = 10000;
    end
    DA(C) = 0;
    % Expan玢o de cidades
    while (C ~= Destino) && (C ~= 0)
        for i = 1:N
            if (D(C,i)~=0)&&(ExpA(i)==0)
                NovaDA = DA(C) + D(C,i);
                if NovaDA < DA(i)
                    DA(i) = NovaDA;
                    Ant(i) = C;
                end
            end
        end
        % Determina玢o do proximo C
        ExpA(C) = 1;
        Min = 10000;
        C = 0;
        for i = 1:N
            if(ExpA(i)==0)&&(DA(i)<Min)
                Min = DA(i);
                C = i;
            end
        end
    end
    if C == Destino
        disp('Caminho mais curto \n');
        disp(Destino);
        while C ~= Origem
            C = Ant(C);
            disp(C);
        end
    else
        disp('N鉶 existe caminho unindo as duas cidades \n');
    end
end