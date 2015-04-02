function [ canais, fdp, pesos_canal_final ] = main( imagem, varargin )

%Main: Função principal que recebe a imagem original e as imagens marcadas
%e retorna as regiões desejadas
%   Essa função apenas chama as outras funções, logo ela não deve ter
%   operações matemáticas nem de busca.

% Variáveis globais (constantes durante todo o algortimo)
Nc = 19; % número de canais
fator = 3; % número de desvios padrões utiliados para construir o filtro    
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
pesos_canal(r,r,Nc) = 0; % matriz para armazenar os pesos combinados 2 a 2 entre as regiões de interesse
% matriz temporária para armazenar as 2 FDP's a serem usadas para o cálculo
% do peso
pesos_canal_final(1,Nc) = 0; % vetor que armazena o peso final de cada canal
for k=1:Nc
    for i=1:r
        for j=1:r
            if i==j
            % se i = j não faz nada
            elseif pesos_canal(j,i,k) == 0;
                % Se i != j verifica se a posição (j,i) é diferente de
                % zero, se for, então calcula o peso para (i,j)
                pesos_canal(i,j,k) = getWeight(vertcat(fdp(i,:,:),fdp(j,:,:)),Nc,k);
            else
                
            end
        end
    end
end

for i=1:Nc
    pesos_canal_final(1,i) = sum(sum(pesos_canal(:,:,i)));
end

% --- Cálculo da probabilidade de um pixel pertencer a uma região de
% interesse





end

