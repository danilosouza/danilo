function [ canais, fdp, peso_canal ] = main( imagem, varargin )
%Main: Função principal que recebe a imagem original e as imagens marcadas
%e retorna as regiões desejadas
%   Essa função apenas chama as outras funções, logo ela não deve ter
%   operações matemáticas nem de busca.

% Variáveis globais (constantes durante todo o algortimo)
Nc = 19;
fator = 3;
% Calculando a FDP dos pixels das regiões de interesse
% Esta função retorna:
    % Uma matriz com as imagens marcadas
    % Uma matriz com a informação espacial dos pixels das regiões de interesse
    % Uma matriz com os valores dos pixels das regiões de interesse
    % Uma matriz com a FDP das regiões de interesse
    
%regioes = cell2str(varargin); % COnverte a célula com os nomes das imagens rabiscadas em string
[ ~, mat_posicao, ~, ~ ] = getPixelsValues(imagem, varargin);

% Calculando os canais utilizados para separar as regiões de interesse
% Esta função retorna:
    % Uma matriz com os 16 filtros de Gabor
    % Uma matriz com a FDP dos pixels da região de interesse para todos os
    %canais
    % Uma matriz com a saída da filtragem da Luminância utilizando os
    %filtros calculados
    % Uma matriz com todos os canais
fator = 3; % Fator que determina quantos desvios padrões em torno da média utilizar para contruir os filtros
[~, fdp, ~, canais] = getChannels(imagem,  mat_posicao, fator);

% --- Econtrando o peso dos canais
[r,~,~] = size(fdp); % guarda o número de regiões de interesse
pesos_canal(r,r) = 0; % criar uma matriz para armazenar os pesos combinados 2 a 2 entre as regiões de interesse

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

% --- Cálculo da probabilidade de um pixel pertencer a uma região de
% interesse




end

