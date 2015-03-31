function [ peso_canal ] = getWeight( fdp, Nc )
%getWeight Calcula o peso de cada canal
%   Essa função recebe como parâmetro uma matriz com as FDP's de todos as
%   regiões de interesse para cada canal e a partir desses valores
%   encontrar a função mínimo para cada canal e então calcula o peso do
%   canal

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

peso_canal(1,Nc) = 0;
P_min_soma = sum(1./P_min);
for i=1:Nc
    peso_canal(1,i) = (1/P_min(1,i))/P_min_soma;
end

end

