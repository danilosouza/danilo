function [ fdp, img, mat_posicao,resultado_final] = segmenta( imagem, varargin )

%Main: Fun��o principal que recebe a imagem original e as imagens marcadas
%
%   Esta fun��o utiliza as fun��es secund�rias para realizar as opera��es
%   mais b�sicas, por�m a opera��o de segmenta��o � realizada por esta.


% ########################################################### %
% #                                                         # %
% #     Recuperar os valores e posi��o dos pixels marcados  # %
% #                                                         # %
% ########################################################### %
% Esta fun��o retorna:
    % Uma matriz com os valores dos pixels das regi�es de interesse e a
    % informa��o espacial destes
    % A imagem original
    % Um vetor que indica quantas subregi�es existem em ccada regi�o

[ ~, mat_posicao, ~, ~, img, n_sub_labels ] = getPixelsPosition(imagem, varargin);


% ############################################################### %
% #                                                             # %
% #  Encontrando os canais e suas respectivas FDP's por regi�o  # %
% #                                                             # %
% ############################################################### %

% Calculando os canais utilizados para separar as regi�es de interesse
% Esta fun��o retorna:
    % Uma matriz com FDP dos pixels de cada subregi�o
    % O n�mero total de canais
fator = 3; % Fator que determina quantos desvios padr�es em torno da m�dia utilizar para contruir os filtros
[~, fdp, ~, ~, Nc] = getChannels(imagem,  mat_posicao, fator, n_sub_labels);

% ############################################################### %
% #                                                             # %
% #  Encontrando o peso dos canais                              # %
% #                                                             # %
% ############################################################### %
% Esta fun��o retorna:
    % Um vetor com o peso de cada canal
    
% guarda o n�mero de regi�es e de subregi�es de interesse 
[s,~,r,~] = size(fdp);
% vetor que armazena o peso de cada canal
pesos_canal_final(1,Nc) = 0; 

% Calcula o peso de cada canal considerando o conjunto de FDP's, o n�mero
% de canais e o canal desejado
for k=1:Nc
    pesos_canal_final(1,k) = getChannelWeight(fdp,Nc,k,n_sub_labels);
end

% ############################################################### %
% #                                                             # %
% #  Encontrando o peso da dist�ncia dos canais                 # %
% #                                                             # %
% ############################################################### %
% Esta fun��o retorna:
    % Uma matriz com os pesos para cada subregi�o por pixel no intervalo
    % [0,255]

% Matriz para indicar quais regi�es e subregi�es de fato existem na imagem,
% uma vez que algumas regi�es podem ter menos subregi�es que outras
indices(r,s,256) = 0;
% Matriz que armazena os pesos temporariamente
pesos_geo(r,s,256) = 0;
% Matriz que armazena o peso final de cada conjunto regi�o/subregi�o
pesos_geo_final(r,s,256) = 0;

% --- La�o para preencher com '1's as regi�es e subregi�es que de fato
% existem na imagem

[~,reg] = size(n_sub_labels);
for k=1:256
    for i=1:reg
        for j=1:n_sub_labels(1,i)
            indices(i,j,k) = 1;
        end
    end
end

% ########## C�lculo do peso da dist�nia para todos os pixels no intervalo
% [0,255] para cada subregi�o. ##########


for k=1:256
    for i=1:r
        for j=1:s
            % Verifica se o conjunto regi�o/subregi�o � valido
            if indices(i,j,k) == 1
                % Percorre a matriz com os indices dos pesos novamente afim
                % de fazer o c�lculo do conjunto regi�o/subregi�o atual em
                % compara��o 2 a 2 com as outras subregi�es das outras
                % regi�es (subregi�es da mesma regi�o n�o s�o comparadas
                % umas com as outras)
                for a=1:r
                    for b=1:s
                        if indices(a,b,k) == 1 && a ~= i
                            pesos_geo(a,b,k) = getGeodesicWeight(fdp,[i a],[j b], Nc,pesos_canal_final,k);

                            pesos_geo_final(i,j,k) = pesos_geo_final(i,j,k) + pesos_geo(a,b,k);
                        else
                            % Se n�o existir o conjunto regi�o/subregi�o,
                            % ent�o n�o � necess�rio calcular o peso
                        end
                    end
                end
            else
                % Se  n�o existir o conjunto regi�o/subregi�o, ent�o n�o �
                % necess�rio calcular o peso
            end  
        end
    end
    
end


% ############################################################### %
% #                                                             # %
% #  Segmentado a imagem (baseado na probabilidade)             # %
% #                                                             # %
% ############################################################### %
% Esta fun��o retorna:
    % Uma matriz com a menor dist�ncia do pixel atual para cada subregi�o
    % da imagem. Esta dist�ncia � utilizada para calcular a probabilidade
    % do pixel atual pertencer a uma dada subregi�o.

[N,M,~,~] = size(mat_posicao);
% Vetor que guarda a menor dist�ncia do pixel corrente para as regi�es de
% interesse
dist_min(r,s) = 0;
% Vari�vel que determina a probabilidade de um pixel pertencer a um regi�o
% de interesse
probabilidade(r,s) = 0;


img = imread(imagem);
[~,~,C] = size(img);
% Matriz que vai armazenar os pixels segmentados de acordo com cada regi�o
%resultado_final(N,M,s,r) = 0;
resultado_final(N,M,C,s,r) = 0;
for i=1:N
    for j=1:M
        for k=1:r
            for l=1:s
                if indices(k,l,:) == 1
                    dist_min(k,l) = getMinDistance(mat_posicao(:,:,l,k),[i j],pesos_geo_final(k,l,img(i,j)+1));
                else
                    % Se n�o h� o conjunto regi�o/subregi�o ent�o n�o faz
                    % nada
                end
            end
        end
        for k=1:r
            for l=1:s
                if dist_min(k,l) == 0 && indices(k,l) == 1
                    probabilidade(k,l) = 1;
                elseif indices(k,l) == 1
                    % leva em considera��o apenas os valores n�o nulos na
                    % hora de calcular a probabilidade, representando
                    % apenas os conjuntos regi�o/subregi�o v�lidos
                    [~,~,v] = find(dist_min);
                    probabilidade(k,l) = (1/dist_min(k,l))/(sum(1./v));
                end
            end
        end
        % Descobre a qual regi�o/subregi�o o pixel atual tem maior
        % probabilidade de pertencer.
        [~, index_subregiao] = max(max(probabilidade,[],1));
        [~, index_regiao] = max(max(probabilidade,[],2));
        
        % Armazena os valores da imagem RGB referentes a posi��o do pixel
        % atual de acordo com sua subregi�o
        resultado_final(i,j,:,index_subregiao,index_regiao) = img(i,j,:);
    end
end

end

