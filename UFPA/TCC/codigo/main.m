function [ canais, fdp, peso_canal ] = main( imagem, varargin )
%Main: Fun��o principal que recebe a imagem original e as imagens marcadas
%e retorna as regi�es desejadas
%   Essa fun��o apenas chama as outras fun��es, logo ela n�o deve ter
%   opera��es matem�ticas nem de busca.

% Vari�veis globais (constantes durante todo o algortimo)
Nc = 19;
fator = 3;
% Calculando a FDP dos pixels das regi�es de interesse
% Esta fun��o retorna:
    % Uma matriz com as imagens marcadas
    % Uma matriz com a informa��o espacial dos pixels das regi�es de interesse
    % Uma matriz com os valores dos pixels das regi�es de interesse
    % Uma matriz com a FDP das regi�es de interesse
    
%regioes = cell2str(varargin); % COnverte a c�lula com os nomes das imagens rabiscadas em string
[ ~, mat_posicao, ~, ~ ] = getPixelsValues(imagem, varargin);

% Calculando os canais utilizados para separar as regi�es de interesse
% Esta fun��o retorna:
    % Uma matriz com os 16 filtros de Gabor
    % Uma matriz com a FDP dos pixels da regi�o de interesse para todos os
    %canais
    % Uma matriz com a sa�da da filtragem da Lumin�ncia utilizando os
    %filtros calculados
    % Uma matriz com todos os canais
fator = 3; % Fator que determina quantos desvios padr�es em torno da m�dia utilizar para contruir os filtros
[~, fdp, ~, canais] = getChannels(imagem,  mat_posicao, fator);

% --- Econtrando o peso dos canais
[r,~,~] = size(fdp); % guarda o n�mero de regi�es de interesse
pesos_canal(r,r) = 0; % criar uma matriz para armazenar os pesos combinados 2 a 2 entre as regi�es de interesse

for i=1:r
    for j=1:r
        if i==j
            
        else
            fdp_temp = fdp()
            pesos_canal(i,j) = getWeight(fdp_temp,Nc);
        end
    end
end
%peso_canal = getWeight(fdp,Nc);

% --- C�lculo da probabilidade de um pixel pertencer a uma regi�o de
% interesse




end

