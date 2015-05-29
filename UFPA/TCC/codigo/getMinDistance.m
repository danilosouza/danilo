function [ dist_min ] = getMinDistance( posicao_regiao, pos_pixel, peso_geo )
%getMinDistance Função para calcular a distância mínima de um dado pixel
%para os pixels de uma região de interesse

%   Essa função recebe como parâmmetro a matriz com a posição dos pixels da
%   região de interesse a ser analisada, a posição do pixel de interesse e
%   o peso da distância geodésica para o pixel para a região de interesse
%   correspondente

[r, c, v] = find(posicao_regiao);

%Variável que guarda a distância entre o pixel desejado e os pixels da
%região de interesse, considerando o peso
dist(1,size(v,1)) = 0;
for k=1:size(v,1)
    dist(1,k) = peso_geo*sqrt(((pos_pixel(1,1)- r(k,1))^2) + (((pos_pixel(1,2)- c(k,1))^2)));
end
dist_min = min(dist);
end

