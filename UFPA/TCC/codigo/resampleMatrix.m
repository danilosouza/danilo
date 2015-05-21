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
[~, ~, v] = find(mat_posicao);
%taxa = 10;
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



end

