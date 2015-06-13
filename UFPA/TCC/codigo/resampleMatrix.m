function [ matriz] = resampleMatrix( mat_posicao )
%resampleMatrix - Esta função faz a reamostragem dos pixels das subregiões
%de interesse
%   Essa função recebe a matriz original com a informação dos pixels das
%   subregiões de interesse e retorna uma matriz de mesmas dimensões com as
%   pixels reamostrados.

% Reamostrando os pixels do conjunto de pixels da subregião atual para
% usando uma reamostragem de "taxa" (em %).
[N,M] = size(mat_posicao);
matriz(N,M) = 0;
%taxa = 10;

% ############## Método 1 ############## 
    % Este método reamostra a matriz pegando valores que estão "fator"
    % vezes acima e abaixo da média da FDP dos pixels em questão.
%{    
media = mean(v);
desvio = sqrt(var(v));
fator = 2;
for i=1:N
    for j=1:M
        if mat_posicao(i,j) ~= 0 && mat_posicao(i,j) < (media-fator*desvio)
            matriz(i,j) = mat_posicao(i,j);
        elseif mat_posicao(i,j) ~= 0 && mat_posicao(i,j) > (media+fator*desvio)
            matriz(i,j) = mat_posicao(i,j);
        end
    end
end
%}
% ############## Método 2 ############## 
    % Este método reamostra a matriz pegando valores escolhidos de forma
    % aleatória dentre todos os valores disponíveis. A quantidade de
    % valores que serão escolhidos é dada por "taxa".
[r, c, v] = find(mat_posicao);
taxa = 1;
%temp = horzcat(r,c,v);

% Verifica o percental de pixels será utilizado e caso a taxa seja igual a
% 100% não faz a remostragem, caso contrário a reamostragem é feita.
if taxa == 1
    matriz = mat_posicao;
else
    % adiciona 1 para corrigir os casos em que o número de pixels e a taxa 
        % são pequenos e o round seria '0'.
    for i=1:round(size(v,1)*taxa)
        index_temp = round(rand * size(v,1));
        if index_temp == 0
            index_temp = index_temp + 1;
        else
        end
        matriz((r(index_temp,1)),(c(index_temp,1))) = v(index_temp,1);
    end    
end
end

