function [ canais, fdp, pesos_canal_final, img, pesos_geo_final, mat_posicao, dist_min, probabilidade] = main( imagem, varargin )

%Main: Função principal que recebe a imagem original e as imagens marcadas
%e retorna as regiões desejadas
%   Essa função apenas chama as outras funções, logo ela não deve ter
%   operações matemáticas nem de busca.

% Variáveis globais (constantes durante todo o algortimo)
Nc = 19; % número de canais
fator = 3; % número de desvios padrões utiliados para construir o filtro 
[N,M] = size(imagem);
% Calculando a FDP dos pixels das regiões de interesse
% Esta função retorna:
    % Uma matriz com as imagens marcadas
    % Uma matriz com a informação espacial dos pixels das regiões de interesse
    % Uma matriz com os valores dos pixels das regiões de interesse
    % Uma matriz com a FDP das regiões de interesse

[ ~, mat_posicao, ~, ~, img ] = getPixelsValues(imagem, varargin);

% Calculando os canais utilizados para separar as regiões de interesse
% Esta função retorna:
    % Uma matriz com os 16 filtros de Gabor
    % Uma matriz com a FDP dos pixels da região de interesse para todos os
    %canais
    % Uma matriz com a saída da filtragem da Luminância utilizando os
    %filtros calculados
    % Uma matriz com todos os canais
fator = 3; % Fator que determina quantos desvios padrões em torno da média utilizar para contruir os filtros
[~, fdp, ~, canais, Nc] = getChannels(imagem,  mat_posicao, fator);

% --- Econtrando o peso dos canais
[r,~,~] = size(fdp); % guarda o número de regiões de interesse
pesos_canal_final(1,Nc) = 0; % vetor que armazena o peso de cada canal

% Calcula o peso de cada canal considerando o conjunto de FDP's, o número
% de canais e o canal desejado
for k=1:Nc
    pesos_canal_final(1,k) = getWeight(fdp,Nc,k);
end


% --- Cálculo da probabilidade de um pixel pertencer a uma região de
% interesse e da função peso de cada pixel para todas as regiões de
% interesse, levendo em consideração cada região sendo comparada 2 a 2 com
% as outras.

% Matriz que guarda o peso da distância geodésica para cada região de
% interesse 
pesos_geo(r,r,256) = 0;
pesos_geo_final(r,1,256) = 0;

for k=1:256
    for i=1:r
        for j=1:r
            if i==j
            % se i = j não faz nada
            else 
                pesos_geo(i,j,k) = getGeodesicWeight(fdp,[i j], Nc,pesos_canal_final,k);
            end
        end
    end
    pesos_geo_final(:,1,k) = sum(pesos_geo(:,:,k),2);
end

% ----- Cálculo da distância geodésica entre os pixels da imagem e os
% pixels das regiões de interesse.

[N,M,~] = size(mat_posicao);
% Vetor que guarda a menor distância do pixel corrente para as regiões de
% interesse
dist_min(N,M,r) = 0;
% Variável que determina a probabilidade de um pixel pertencer a um região
% de interesse
probabilidade(N,M,r) = 0;

% Matriz que vai armazenar os pixels segmentados de acordo com cada região
resultado_final(N,M,r) = 0;

for i=1:N
    for j=1:M
        for k=1:r
            dist_min(i,j,k) = getMinDistance(mat_posicao(:,:,r),[i j],pesos_geo_final(r,:,img(i,j)));
        end
        for k=1:r
            probabilidade(i,j,k) = (1/dist_min(i,j,k))/(sum(1/dist_min(i,j,:)));
        end
    end
end






end

