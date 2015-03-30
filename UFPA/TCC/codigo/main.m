function [ canais, fdp, P_min, peso_canal ] = main( imagem, varargin )
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

% --- Encontrar o m�nimo das FDP's de cada canal ---
P_min(Nc,256) = 0; % Vetor que armazena o m�nimo das FDP's de cada canal
for i=1:Nc
    for j=1:256
        fdp_temp = fdp(:,:,i);
        P_min(i,j) = min(fdp_temp(:,j));
    end
end

% --- C�lculo do peso de cada canal

peso_canal(1,Nc) = 0;
soma = sum(sum(P_min));
for i=1:Nc
    peso_canal(1,i) = 0.5*(sum(P_min(i,:)))/soma;
end


end

