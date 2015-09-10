function [ fdp, img, mat_posicao, mat_posicao_nova, resultado_final, qtde_total, tempo] = segmenta(taxa, cor, imagem, varargin )

% Vetor para armazenar o tempo de execu��o de cada parte do algoritmo na
% seguinte ordem:
%   1) Posi��o dos pixels marcados
%   2) C�lculo dos Canais
%   3) Pesos dos canais
%   4) Pesos da dist�ncia geod�sica
%   5) Reamostragem
%   6) Tempo total de segmenta��o
%   7) C�lculo das dist�ncias
%   8) C�lculo das probabilidades

tempo(1,8) = 0;

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
tic;
[ ~, mat_posicao, ~, ~, ~, n_sub_labels ] = getPixelsPosition(cor, imagem, varargin);
% posicao_time 
tempo(1,1) = toc

% ############################################################### %
% #                                                             # %
% #  Encontrando os canais e suas respectivas FDP's por regi�o  # %
% #                                                             # %
% ############################################################### %

% Calculando os canais utilizados para separar as regi�es de interesse
% Esta fun��o retorna:
    % Uma matriz com FDP dos pixels de cada subregi�o
    % O n�mero total de canais
    tic;
fator = 4; % Fator que determina quantos desvios padr�es em torno da m�dia utilizar para contruir os filtros
[~, fdp, ~, ~, Nc] = getChannels(imagem,  mat_posicao, fator, n_sub_labels);
tempo(1,2) = toc
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
tic;
for k=1:Nc
    pesos_canal_final(1,k) = getChannelWeight(fdp,Nc,k,n_sub_labels);
end
tempo(1,3) = toc
% ############################################################### %
% #                                                             # %
% #  Encontrando o peso da dist�ncia geod�sica dos canais       # %
% #                                                             # %
% ############################################################### %
% Esta fun��o retorna:
    % Uma matriz com os pesos para cada subregi�o por pixel no intervalo
    % [0,255]
tic;
% Matriz para indicar quais regi�es e subregi�es de fato existem na imagem,
% uma vez que algumas regi�es podem ter menos subregi�es que outras
indices(r,s) = 0;
% Matriz que armazena os pesos temporariamente
pesos_geo(r,s,256) = 0;
% Matriz que armazena o peso final de cada conjunto regi�o/subregi�o
pesos_geo_final(r,s,256) = 0;

% --- La�o para preencher com '1's as regi�es e subregi�es que de fato
% existem na imagem

[~,reg] = size(n_sub_labels);
for i=1:reg
    for j=1:n_sub_labels(1,i)
        indices(i,j) = 1;
    end
end



% ########## C�lculo do peso da dist�nia para todos os pixels no intervalo
% [0,255] para cada subregi�o. ##########


for k=1:256
    for i=1:r
        for j=1:s
            % Verifica se o conjunto regi�o/subregi�o � valido
            if indices(i,j) == 1
                % Percorre a matriz com os indices dos pesos novamente afim
                % de fazer o c�lculo do conjunto regi�o/subregi�o atual em
                % compara��o 2 a 2 com as outras subregi�es das outras
                % regi�es (subregi�es da mesma regi�o n�o s�o comparadas
                % umas com as outras)
                for a=1:r
                    for b=1:s
                        if indices(a,b) == 1 && a ~= i
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
tempo(1,4) = toc
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


% #####################################################
% #                                                   #   
% #          Reamostrando os pixels marcados          #
% #                                                   #
% #####################################################
 

mat_posicao_nova(N,M,s,r) = 0;

tic;
% Vari�vel que guarda a quantidade total de pixels na imagem (subregi�es x
% regi�es)
qtde_total(s,r) = 0;
for k=1:r
    for l=1:s
        [mat_posicao_nova(:,:,l,k), qtde_total(l,k)] = resampleMatrix(mat_posicao(:,:,l,k),taxa);
    end
end
%}
tempo(1,5) = toc

% --- La�o para preencher com '1's as regi�es e subregi�es que de fato
% existem na imagem ap�s a reamostragem
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
% Matriz que vai armazenar os pixels segmentados de acordo com cada regi�o
%resultado_final(N,M,s,r) = 0;
resultado_final(N,M,C,s,r) = 0;

% Vari�veis para medi��o de tempo de execu��o (debug)
tempo_distancia(N,M) = 0;
tempo_prob(N,M) = 0;
tempo_segmentacao(N,M) = 0;
tempo_segmentacao_total = 0;
tempo_distancia_total = 0;
tempo_prob_total = 0;
count = 0;
flag = 0;
for i=1:N
    for j=1:M
        tic
        for k=1:r
            for l=1:s
                if indices(k,l) == 1
                    [dist_min(k,l)] = getMinDistance(mat_posicao_nova(:,:,l,k),[i j],pesos_geo_final(k,l,img(i,j)+1));
                else
                    % Se n�o h� o conjunto regi�o/subregi�o ent�o n�o faz
                    % nada
                end
            end
        end
        tempo_distancia(i,j) = toc;
        tempo_distancia_total = tempo_distancia_total + tempo_distancia(i,j);
        tic;
        % Cria um vetor com todos os valores de dist�ncia para o pixel
        % analisado.
        [~,~,v] = find(dist_min);
        % Soma o inverso dos valores das dist�nicias
        soma = (sum(1./v));
        for k=1:r
            for l=1:s
                if dist_min(k,l) == 0 && indices(k,l) == 1
                    probabilidade(k,l) = 1;
                elseif indices(k,l) == 1
                    % leva em considera��o apenas os valores n�o nulos na
                    % hora de calcular a probabilidade, representando
                    % apenas os conjuntos regi�o/subregi�o v�lidos
                    probabilidade(k,l) = (1/dist_min(k,l))/soma;
                end
            end
        end
        tempo_prob(i,j) = toc;
        tempo_prob_total = tempo_prob_total + tempo_prob(i,j);
        tic
        % Descobre a qual regi�o/subregi�o o pixel atual tem maior
        % probabilidade de pertencer.
        [~, index_subregiao] = max(max(probabilidade,[],1));
        [~, index_regiao] = max(max(probabilidade,[],2));
        
        count = count + 1;
        
        if round((count/(M*N))*100) == 90 && flag == 0
            flag = 1;
            str = '90% de pixels classificados';
            disp(str);
        elseif round((count/(M*N))*100) == 75 && flag == 1
            flag = 0;
            str = '75% de pixels classificados';
            disp(str);
        elseif round((count/(M*N))*100) == 50 && flag == 0
            flag = 1;
            str = '50% de pixels classificados';
            disp(str);
        elseif round((count/(M*N))*100) == 25 && flag == 1
            flag = 0;
            str = '25% de pixels classificados';
            disp(str);
        elseif round((count/(M*N))*100) <25 && flag == 0
            flag = 1;
            str = 'Menos de 25% de pixels classificados';
            disp(str); 
        end
            
            
            
        % Armazena os valores da imagem RGB referentes a posi��o do pixel
        % atual de acordo com sua subregi�o
        resultado_final(i,j,:,index_subregiao,index_regiao) = img(i,j,:);
        tempo_segmentacao(i,j) = toc;
        tempo_segmentacao_total = tempo_segmentacao_total + tempo_segmentacao(i,j);
    end
end

tempo(1,6) = tempo_segmentacao_total;
tempo(1,7) = tempo_distancia_total;
tempo(1,8) = tempo_prob_total;

end

