function [ dist_min ] = getMinDistance( posicao_regiao, pos_pixel, peso_geo )
%getMinDistance Fun��o para calcular a dist�ncia m�nima de um dado pixel
%para os pixels de uma regi�o de interesse

%   Essa fun��o recebe como par�mmetro a matriz com a posi��o dos pixels da
%   regi�o de interesse a ser analisada, a posi��o do pixel de interesse e
%   o peso da dist�ncia geod�sica para o pixel para a regi�o de interesse
%   correspondente

[r, c, v] = find(posicao_regiao);

%Vari�vel que guarda a dist�ncia entre o pixel desejado e os pixels da
%regi�o de interesse, considerando o peso
dist(1,size(v,1)) = 0;
for k=1:size(v,1)
    dist(1,k) = peso_geo*sqrt(((pos_pixel(1,1)- r(k,1))^2) + (((pos_pixel(1,2)- c(k,1))^2)));
end
dist_min = min(dist);
end

