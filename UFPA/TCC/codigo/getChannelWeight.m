function [ peso_canal ] = getChannelWeight( fdp, Nc, canal, n_sub_labels )
%getWeight Calcula o peso de cada canal
%   Essa função recebe como parâmetro uma matriz com as FDP's de todos as
%   regiões de interesse para cada canal e a partir desses valores
%   encontrar a função mínimo para cada canal e então calcula o peso do
%   canal. Recebe também o canal atual que se está calculando o peso, para
%   saber de qual canal deverá utilizar a FDP

% --- Encontrar o mínimo das FDP's de cada canal ---
[s,~,r,~] = size(fdp);
% Vetor que armazena o mínimo das FDP's de cada canal
minimo(Nc,256) = 0;
% Vetor que armazena o mínimo das FDP's de cada região
fdp_regiao(r,256) = 0;

P_min(1,Nc) = 0;
P_min_regiao(1,r) = 0;

for i=1:Nc
    for k=1:r
        fdp_temp(n_sub_labels(1,k),256) = 0;
        for l=1:n_sub_labels(1,k)
            fdp_temp(l,:) = fdp(l,:,k,i);
        end
        % Verifica quantas subregiões a região atual possui e elimina
        % os zeros da matriz FDP
        fdp_regiao(k,:) = sum(fdp_temp(:,:));
    end
    minimo(i,:) = min(fdp_regiao(:,:));
    P_min(1,i) = (1/r)*sum(minimo(i,:));
end

% --- Cálculo do peso de cada canal


P_min_soma = sum(1./P_min);

peso_canal = (1/P_min(1,canal))/P_min_soma;


end

