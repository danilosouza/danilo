function [ fdp, img, mat_posicao, resultado_final] = main( imagem, varargin )

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

% Calculando os canais utilizados para separar as regi�es de interesse
% Esta fun��o retorna:
    % Uma matriz com os 16 filtros de Gabor
    % Uma matriz com a FDP dos pixels da regi�o de interesse para todos os
    %canais
    % Uma matriz com a sa�da da filtragem da Lumin�ncia utilizando os
    %filtros calculados
    % Uma matriz com todos os canais
fator = 3; % Fator que determina quantos desvios padr�es em torno da m�dia utilizar para contruir os filtros
[~, fdp, ~, canais, Nc] = getChannels(imagem,  mat_posicao, fator, n_sub_labels);

% --- Econtrando o peso dos canais
[r,~,~] = size(fdp); % guarda o n�mero de regi�es de interesse
pesos_canal_final(1,Nc) = 0; % vetor que armazena o peso de cada canal

% Calcula o peso de cada canal considerando o conjunto de FDP's, o n�mero
% de canais e o canal desejado
for k=1:Nc
    pesos_canal_final(1,k) = getWeight(fdp,Nc,k);
end


% --- C�lculo da probabilidade de um pixel pertencer a uma regi�o de
% interesse e da fun��o peso de cada pixel para todas as regi�es de
% interesse, levendo em considera��o cada regi�o sendo comparada 2 a 2 com
% as outras.

% Matriz que guarda o peso da dist�ncia geod�sica para cada regi�o de
% interesse 
pesos_geo(r,r,256) = 0;
pesos_geo_final(r,1,256) = 0;

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

% ----- C�lculo da dist�ncia geod�sica entre os pixels da imagem e os
% pixels das regi�es de interesse.

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






end

