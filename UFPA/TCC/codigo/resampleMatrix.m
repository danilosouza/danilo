function [ matriz] = resampleMatrix( mat_posicao )
%resampleMatrix - Esta fun��o faz a reamostragem dos pixels das subregi�es
%de interesse
%   Essa fun��o recebe a matriz original com a informa��o dos pixels das
%   subregi�es de interesse e retorna uma matriz de mesmas dimens�es com as
%   pixels reamostrados.

% Reamostrando os pixels do conjunto de pixels da subregi�o atual para
% usando uma reamostragem de "taxa" (em %).
[N,M] = size(mat_posicao);
matriz(N,M) = 0;
%taxa = 10;

% ############## M�todo 1 ############## 
    % Este m�todo reamostra a matriz pegando valores que est�o "fator"
    % vezes acima e abaixo da m�dia da FDP dos pixels em quest�o.
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
% ############## M�todo 2 ############## 
    % Este m�todo reamostra a matriz pegando valores escolhidos de forma
    % aleat�ria dentre todos os valores dispon�veis. A quantidade de
    % valores que ser�o escolhidos � dada por "taxa".
[r, c, v] = find(mat_posicao);
taxa = 1;
%temp = horzcat(r,c,v);

% Verifica o percental de pixels ser� utilizado e caso a taxa seja igual a
% 100% n�o faz a remostragem, caso contr�rio a reamostragem � feita.
if taxa == 1
    matriz = mat_posicao;
else
    % adiciona 1 para corrigir os casos em que o n�mero de pixels e a taxa 
        % s�o pequenos e o round seria '0'.
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

