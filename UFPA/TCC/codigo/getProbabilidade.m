function [ probabilidade ] = getProbabilidade( mat_posicao, pos_pixel, peso_geo,r,s,indices)
%getProbabilidade Esta função calcula a probabilidade de um pixel pertencer
% a todas as subregiões de interesse.

%   Essa funnção recebe como entrada a matriz com inormação espacial das
%   subregiões de interesse e calcula baseada na menor distância de um
%   pixel a cada uma dessas subregiões, o probabilidade deste mesmo pixel
%   pertencer a estas regiões.

% Vetor que guarda a menor distância do pixel corrente para as regiões de
% interesse
dist_min(r,s) = 0;
% Variável que determina a probabilidade de um pixel pertencer a um região
% de interesse
probabilidade(r,s) = 0;

for k=1:r
    for l=1:s
        if indices(k,l,:) == 1
            dist_min(k,l) = getMinDistance(mat_posicao(:,:,l,k),pos_pixel,peso_geo(k,l));
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

end

