function [ peso_canal ] = getChannelWeight( fdp, Nc, canal )
%getWeight Calcula o peso de cada canal
%   Essa função recebe como parâmetro uma matriz com as FDP's de todos as
%   regiões de interesse para cada canal e a partir desses valores
%   encontrar a função mínimo para cada canal e então calcula o peso do
%   canal. Recebe também o canal atual que se está calculando o peso, para
%   saber de qual canal deverá utilizar a FDP

% --- Encontrar o mínimo das FDP's de cada canal ---
minimo(Nc,256) = 0; % Vetor que armazena o mínimo das FDP's de cada canal
P_min(1,Nc) = 0;
[r,~,~] = size(fdp);
for i=1:Nc
    for j=1:256
        fdp_temp = fdp(:,:,i);
        minimo(i,j) = min(fdp_temp(:,j));
    end
    P_min(1,i) = (1/r)*sum(minimo(i,:));
end

% --- Cálculo do peso de cada canal


P_min_soma = sum(1./P_min);

peso_canal = (1/P_min(1,canal))/P_min_soma;


end

