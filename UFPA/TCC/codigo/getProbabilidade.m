function [ probabilidade ] = getProbabilidade( mat_posicao, pos_pixel, peso_geo,r,s,indices)
%getProbabilidade Esta fun��o calcula a probabilidade de um pixel pertencer
% a todas as subregi�es de interesse.

%   Essa funn��o recebe como entrada a matriz com inorma��o espacial das
%   subregi�es de interesse e calcula baseada na menor dist�ncia de um
%   pixel a cada uma dessas subregi�es, o probabilidade deste mesmo pixel
%   pertencer a estas regi�es.

% Vetor que guarda a menor dist�ncia do pixel corrente para as regi�es de
% interesse
dist_min(r,s) = 0;
% Vari�vel que determina a probabilidade de um pixel pertencer a um regi�o
% de interesse
probabilidade(r,s) = 0;

for k=1:r
    for l=1:s
        if indices(k,l,:) == 1
            dist_min(k,l) = getMinDistance(mat_posicao(:,:,l,k),pos_pixel,peso_geo(k,l));
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

end

