function [ fdp, img, mat_posicao, resultado_final] = segmenta( imagem, varargin )

%Main: Função principal que recebe a imagem original e as imagens marcadas
%e retorna as regiões desejadas
%   Essa função apenas chama as outras funções, logo ela não deve ter
%   operações matemáticas nem de busca.

% Variáveis globais (constantes durante todo o algortimo)
% Calculando a FDP dos pixels das regiões de interesse
% Esta função retorna:
    % Uma matriz com as imagens marcadas
    % Uma matriz com a informação espacial dos pixels das regiões de interesse
    % Uma matriz com os valores dos pixels das regiões de interesse
    % Uma matriz com a FDP das regiões de interesse

[ ~, mat_posicao, ~, ~, img, n_sub_labels ] = getPixelsValues(imagem, varargin);

% ##### Encontrando os canais e suas respectivas FDP's por região #####
% Calculando os canais utilizados para separar as regiões de interesse
% Esta função retorna:
    % Uma matriz com os 16 filtros de Gabor
    % Uma matriz com a FDP dos pixels da região de interesse para todos os
    %canais
    % Uma matriz com a saída da filtragem da Luminância utilizando os
    %filtros calculados
    % Uma matriz com todos os canais
fator = 3; % Fator que determina quantos desvios padrões em torno da média utilizar para contruir os filtros
[~, fdp, ~, ~, Nc] = getChannels(imagem,  mat_posicao, fator, n_sub_labels);

% ##### Econtrando o peso dos canais #####
% guarda o número de regiões e de subregiões de interesse 
 [s,~,r,~] = size(fdp);
pesos_canal_final(1,Nc) = 0; % vetor que armazena o peso de cada canal

% Calcula o peso de cada canal considerando o conjunto de FDP's, o número
% de canais e o canal desejado
for k=1:Nc
    pesos_canal_final(1,k) = getChannelWeight(fdp,Nc,k,n_sub_labels);
end


% ##### Cálculo da probabilidade de um pixel pertencer a uma região de
% interesse e da função peso de cada pixel para todas as regiões de
% interesse, levendo em consideração cada região sendo comparada 2 a 2 com
% as outras. #####

% Matriz que guarda o peso da distância geodésica para cada região de
% interesse 
%pesos_geo(r,r,256) = 0;
%pesos_geo_final(r,1,256) = 0;

% Matriz para indicar quais regiões e subregiões de fato existem na imagem,
% uma vez que algumas regiões podem ter menos subregiões que outras
indices(r,s,256) = 0;
% Matriz que armazena os pesos temporariamente
pesos_geo(r,s,256) = 0;
% Matriz que armazena o peso final de cada conjunto região/subregião
pesos_geo_final(r,s,256) = 0;

% --- Laço para preencher com '1's as regiões e subregiões que de fato
% existem na imagem

[~,reg] = size(n_sub_labels);
for k=1:256
    for i=1:reg
        for j=1:n_sub_labels(1,i)
            indices(i,j,k) = 1;
        end
    end
end


for k=1:256
    for i=1:r
        for j=1:s
            % Verifica se o conjunto região/subregião é valido
            if indices(i,j,k) == 1
                % Percorre a matriz com os indices dos pesos novamente afim
                % de fazer o cálculo do conjunto região/subregião atual em
                % comparação 2 a 2 com as outras subregiões das ouras
                % regiões
                for a=1:r
                    for b=1:s
                        if indices(a,b,k) == 1 && a ~= i
                            pesos_geo(a,b,k) = getGeodesicWeight(fdp,[i a],[j b], Nc,pesos_canal_final,k);

                            pesos_geo_final(i,j,k) = pesos_geo_final(i,j,k) + pesos_geo(a,b,k);
                        else
                            % Se não existir o conjunto região/subregião,
                            % então não é necessário calcular o peso
                        end
                    end
                end
            else
                % Se  não existir o conjunto região/subregião, então não é
                % necessário calcular o peso
            end  
        end
    end
    
end

% ##### Cálculo da distância geodésica entre os pixels da imagem e os
% pixels das regiões de interesse. #####

[N,M,~,~] = size(mat_posicao);
% Vetor que guarda a menor distância do pixel corrente para as regiões de
% interesse
dist_min(r,s) = 0;
% Variável que determina a probabilidade de um pixel pertencer a um região
% de interesse
probabilidade(r,s) = 0;

% Matriz que vai armazenar os pixels segmentados de acordo com cada região
resultado_final(N,M,s,r) = 0;
%resultado_final(N,M,3,s,r) = 0;
%img = imread(imagem);
for i=1:N
    for j=1:M
        for k=1:r
            for l=1:s
                if indices(k,l,:) == 1
                    dist_min(k,l) = getMinDistance(mat_posicao(:,:,l,k),[i j],pesos_geo_final(k,l,img(i,j)+1));
                else
                    % Se não há o conjunto região/subregião então não faz
                    % nada
                end
            end
        end
        for k=1:r
            for l=1:s
                if dist_min(k,l) == 0 && indices(k,l) == 1
                    probabilidade(k,l) = 1;
                elseif indices(k,l) == 1
                    % leva em consideração apenas os valores não nulos na
                    % hora de calcular a probabilidade, representando
                    % apenas os conjuntos região/subregião válidos
                    [~,~,v] = find(dist_min);
                    probabilidade(k,l) = (1/dist_min(k,l))/(sum(1./v));
                end
            end
        end
        [~, index_subregiao] = max(max(probabilidade,[],1));
        [~, index_regiao] = max(max(probabilidade,[],2));
        resultado_final(i,j,index_subregiao,index_regiao) = img(i,j,1);
        %resultado_final(i,j,1,index_subregiao,index_regiao) = img(i,j,1);
        %resultado_final(i,j,2,index_subregiao,index_regiao) = img(i,j,2);
        %resultado_final(i,j,3,index_subregiao,index_regiao) = img(i,j,3);
    end
end

% ------ Código que não considera subregiões ------
%{
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

% ##### Cálculo da distância geodésica entre os pixels da imagem e os
% pixels das regiões de interesse. #####

[N,M,~] = size(mat_posicao);
% Vetor que guarda a menor distância do pixel corrente para as regiões de
% interesse
dist_min(1,r) = 0;
% Variável que determina a probabilidade de um pixel pertencer a um região
% de interesse
probabilidade(1,r) = 0;

% Matriz que vai armazenar os pixels segmentados de acordo com cada região
resultado_final(N,M,3,r) = 0;
img = imread(imagem);
for i=1:N
    for j=1:M
        for k=1:r
            dist_min(1,k) = getMinDistance(mat_posicao(:,:,k),[i j],pesos_geo_final(k,:,img(i,j)+1));
        end
        for k=1:r
            if dist_min(1,k) == 0
                probabilidade(1,k) = 1;
            else
                probabilidade(1,k) = (1/dist_min(1,k))/(sum(1./dist_min(1,:)));
            end
        end
        [~, index] = max(probabilidade(1,:));
        resultado_final(i,j,1,index) = img(i,j,1);
        resultado_final(i,j,2,index) = img(i,j,2);
        resultado_final(i,j,3,index) = img(i,j,3);
    end
end
%}





end

