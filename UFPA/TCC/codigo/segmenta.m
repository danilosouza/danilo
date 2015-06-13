function [ fdp, img, mat_posicao, mat_posicao_nova, resultado_final] = segmenta( imagem, varargin )

%Main: Função principal que recebe a imagem original e as imagens marcadas
%
%   Esta função utiliza as funções secundárias para realizar as operações
%   mais básicas, porém a operação de segmentação é realizada por esta.


% ########################################################### %
% #                                                         # %
% #     Recuperar os valores e posição dos pixels marcados  # %
% #                                                         # %
% ########################################################### %
% Esta função retorna:
    % Uma matriz com os valores dos pixels das regiões de interesse e a
    % informação espacial destes
    % A imagem original
    % Um vetor que indica quantas subregiões existem em ccada região
tic;
[ ~, mat_posicao, ~, ~, img, n_sub_labels ] = getPixelsPosition(imagem, varargin);
posicao_time = toc

% ############################################################### %
% #                                                             # %
% #  Encontrando os canais e suas respectivas FDP's por região  # %
% #                                                             # %
% ############################################################### %

% Calculando os canais utilizados para separar as regiões de interesse
% Esta função retorna:
    % Uma matriz com FDP dos pixels de cada subregião
    % O número total de canais
    tic;
fator = 3; % Fator que determina quantos desvios padrões em torno da média utilizar para contruir os filtros
[~, fdp, ~, ~, Nc] = getChannels(imagem,  mat_posicao, fator, n_sub_labels);
canal_time = toc
% ############################################################### %
% #                                                             # %
% #  Encontrando o peso dos canais                              # %
% #                                                             # %
% ############################################################### %
% Esta função retorna:
    % Um vetor com o peso de cada canal
    
% guarda o número de regiões e de subregiões de interesse 
[s,~,r,~] = size(fdp);
% vetor que armazena o peso de cada canal
pesos_canal_final(1,Nc) = 0; 

% Calcula o peso de cada canal considerando o conjunto de FDP's, o número
% de canais e o canal desejado
tic;
for k=1:Nc
    pesos_canal_final(1,k) = getChannelWeight(fdp,Nc,k,n_sub_labels);
end
peso_canal_time = toc
% ############################################################### %
% #                                                             # %
% #  Encontrando o peso da distância dos canais                 # %
% #                                                             # %
% ############################################################### %
% Esta função retorna:
    % Uma matriz com os pesos para cada subregião por pixel no intervalo
    % [0,255]
tic;
% Matriz para indicar quais regiões e subregiões de fato existem na imagem,
% uma vez que algumas regiões podem ter menos subregiões que outras
indices(r,s) = 0;
% Matriz que armazena os pesos temporariamente
pesos_geo(r,s,256) = 0;
% Matriz que armazena o peso final de cada conjunto região/subregião
pesos_geo_final(r,s,256) = 0;

% --- Laço para preencher com '1's as regiões e subregiões que de fato
% existem na imagem

[~,reg] = size(n_sub_labels);
for i=1:reg
    for j=1:n_sub_labels(1,i)
        indices(i,j) = 1;
    end
end



% ########## Cálculo do peso da distânia para todos os pixels no intervalo
% [0,255] para cada subregião. ##########


for k=1:256
    for i=1:r
        for j=1:s
            % Verifica se o conjunto região/subregião é valido
            if indices(i,j) == 1
                % Percorre a matriz com os indices dos pesos novamente afim
                % de fazer o cálculo do conjunto região/subregião atual em
                % comparação 2 a 2 com as outras subregiões das outras
                % regiões (subregiões da mesma região não são comparadas
                % umas com as outras)
                for a=1:r
                    for b=1:s
                        if indices(a,b) == 1 && a ~= i
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
peso_geo_time = toc
% ############################################################### %
% #                                                             # %
% #  Segmentado a imagem (baseado na probabilidade)             # %
% #                                                             # %
% ############################################################### %
% Esta função retorna:
    % Uma matriz com a menor distância do pixel atual para cada subregião
    % da imagem. Esta distância é utilizada para calcular a probabilidade
    % do pixel atual pertencer a uma dada subregião.

[N,M,~,~] = size(mat_posicao);
% Vetor que guarda a menor distância do pixel corrente para as regiões de
% interesse
dist_min(r,s) = 0;
% Variável que determina a probabilidade de um pixel pertencer a um região
% de interesse
probabilidade(r,s) = 0;



% ########## Reamostrando os pixels marcados ##########
mat_posicao_nova(N,M,s,r) = 0;

tic;
for k=1:r
    for l=1:s
        mat_posicao_nova(:,:,l,k) = resampleMatrix(mat_posicao(:,:,l,k));
    end
end
%}
resample_time = toc

% --- Laço para preencher com '1's as regiões e subregiões que de fato
% existem na imagem após a reamostragem
indices = [];
indices(r,s) = 0;
[~,reg] = size(n_sub_labels);
for i=1:reg
    for j=1:n_sub_labels(1,i)
        [~, ~, v] = find(mat_posicao_nova(:,:,j,i));
        if size(v,1) ~=0
            indices(i,j) = 1;
        else
            
        end
    end
end

img = imread(imagem);
[~,~,C] = size(img);
% Matriz que vai armazenar os pixels segmentados de acordo com cada região
%resultado_final(N,M,s,r) = 0;
resultado_final(N,M,C,s,r) = 0;

% Variáveis para medição de tempo de execução (debug)
tempo_distancia(N,M) = 0;
tempo_prob(N,M) = 0;
tempo_segmentacao(N,M) = 0;
tempo_segmentacao_total = 0;
tempo_distancia_total = 0;
tempo_prob_total = 0;
for i=1:N
    for j=1:M
        tic
        for k=1:r
            for l=1:s
                if indices(k,l) == 1
                    [dist_min(k,l)] = getMinDistance(mat_posicao_nova(:,:,l,k),[i j],pesos_geo_final(k,l,img(i,j)+1));
                else
                    % Se não há o conjunto região/subregião então não faz
                    % nada
                end
            end
        end
        tempo_distancia(i,j) = toc;
        tempo_distancia_total = tempo_distancia_total + tempo_distancia(i,j);
        tic;
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
        tempo_prob(i,j) = toc;
        tempo_prob_total = tempo_prob_total + tempo_prob(i,j);
        tic
        % Descobre a qual região/subregião o pixel atual tem maior
        % probabilidade de pertencer.
        [~, index_subregiao] = max(max(probabilidade,[],1));
        [~, index_regiao] = max(max(probabilidade,[],2));
        
            % Armazena os valores da imagem RGB referentes a posição do pixel
        % atual de acordo com sua subregião
        resultado_final(i,j,:,index_subregiao,index_regiao) = img(i,j,:);
        tempo_segmentacao(i,j) = toc;
        tempo_segmentacao_total = tempo_segmentacao_total + tempo_segmentacao(i,j);
    end
end

tempo_segmentacao_total
tempo_distancia_total
tempo_prob_total

end

