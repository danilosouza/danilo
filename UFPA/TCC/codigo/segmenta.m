function [ fdp, img, mat_posicao, resultado_final] = segmenta( imagem, varargin )

%Main: Fun��o principal que recebe a imagem original e as imagens marcadas
%e retorna as regi�es desejadas
%   Essa fun��o apenas chama as outras fun��es, logo ela n�o deve ter
%   opera��es matem�ticas nem de busca.

% Vari�veis globais (constantes durante todo o algortimo)
% Calculando a FDP dos pixels das regi�es de interesse
% Esta fun��o retorna:
    % Uma matriz com as imagens marcadas
    % Uma matriz com a informa��o espacial dos pixels das regi�es de interesse
    % Uma matriz com os valores dos pixels das regi�es de interesse
    % Uma matriz com a FDP das regi�es de interesse

[ ~, mat_posicao, ~, ~, img, n_sub_labels ] = getPixelsValues(imagem, varargin);

% ##### Encontrando os canais e suas respectivas FDP's por regi�o #####
% Calculando os canais utilizados para separar as regi�es de interesse
% Esta fun��o retorna:
    % Uma matriz com os 16 filtros de Gabor
    % Uma matriz com a FDP dos pixels da regi�o de interesse para todos os
    %canais
    % Uma matriz com a sa�da da filtragem da Lumin�ncia utilizando os
    %filtros calculados
    % Uma matriz com todos os canais
fator = 3; % Fator que determina quantos desvios padr�es em torno da m�dia utilizar para contruir os filtros
[~, fdp, ~, ~, Nc] = getChannels(imagem,  mat_posicao, fator, n_sub_labels);

% ##### Econtrando o peso dos canais #####
% guarda o n�mero de regi�es e de subregi�es de interesse 
 [s,~,r,~] = size(fdp);
pesos_canal_final(1,Nc) = 0; % vetor que armazena o peso de cada canal

% Calcula o peso de cada canal considerando o conjunto de FDP's, o n�mero
% de canais e o canal desejado
for k=1:Nc
    pesos_canal_final(1,k) = getChannelWeight(fdp,Nc,k,n_sub_labels);
end


% ##### C�lculo da probabilidade de um pixel pertencer a uma regi�o de
% interesse e da fun��o peso de cada pixel para todas as regi�es de
% interesse, levendo em considera��o cada regi�o sendo comparada 2 a 2 com
% as outras. #####

% Matriz que guarda o peso da dist�ncia geod�sica para cada regi�o de
% interesse 
%pesos_geo(r,r,256) = 0;
%pesos_geo_final(r,1,256) = 0;

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


for k=1:256
    for i=1:r
        for j=1:s
            % Verifica se o conjunto regi�o/subregi�o � valido
            if indices(i,j,k) == 1
                % Percorre a matriz com os indices dos pesos novamente afim
                % de fazer o c�lculo do conjunto regi�o/subregi�o atual em
                % compara��o 2 a 2 com as outras subregi�es das ouras
                % regi�es
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

% ##### C�lculo da dist�ncia geod�sica entre os pixels da imagem e os
% pixels das regi�es de interesse. #####

[N,M,~,~] = size(mat_posicao);
% Vetor que guarda a menor dist�ncia do pixel corrente para as regi�es de
% interesse
dist_min(r,s) = 0;
% Vari�vel que determina a probabilidade de um pixel pertencer a um regi�o
% de interesse
probabilidade(r,s) = 0;

% Matriz que vai armazenar os pixels segmentados de acordo com cada regi�o
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
        [~, index_subregiao] = max(max(probabilidade,[],1));
        [~, index_regiao] = max(max(probabilidade,[],2));
        resultado_final(i,j,index_subregiao,index_regiao) = img(i,j,1);
        %resultado_final(i,j,1,index_subregiao,index_regiao) = img(i,j,1);
        %resultado_final(i,j,2,index_subregiao,index_regiao) = img(i,j,2);
        %resultado_final(i,j,3,index_subregiao,index_regiao) = img(i,j,3);
    end
end

% ------ C�digo que n�o considera subregi�es ------
%{
for k=1:256
    for i=1:r
        for j=1:r
            if i==j
            % se i = j n�o faz nada
            else 
                pesos_geo(i,j,k) = getGeodesicWeight(fdp,[i j], Nc,pesos_canal_final,k);
            end
        end
    end
    pesos_geo_final(:,1,k) = sum(pesos_geo(:,:,k),2);
end

% ##### C�lculo da dist�ncia geod�sica entre os pixels da imagem e os
% pixels das regi�es de interesse. #####

[N,M,~] = size(mat_posicao);
% Vetor que guarda a menor dist�ncia do pixel corrente para as regi�es de
% interesse
dist_min(1,r) = 0;
% Vari�vel que determina a probabilidade de um pixel pertencer a um regi�o
% de interesse
probabilidade(1,r) = 0;

% Matriz que vai armazenar os pixels segmentados de acordo com cada regi�o
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

