function [ peso_geo ] = getGeodesicWeight( fdp, regioes, Nc, pesos_canal,pixel )
%getGeodesicWeight Função que calcula o peso associado com a distância
%geodésica, baseado na probabilidade de um determinado pixel pertencer a
%uma dada região de interesse
%   Essa função recebe como parâmetro a FDP de todas as regiões de
%   interesse e as regiões de interesse para qual o peso está sendo
%   calculado. A probabilidade calculada é a de um pixels pertencer a uma
%   dada região. A função
%   recebe também o peso dos canais para realizar o cálculo das
%   probabilidades em função da capacidade de cada canal em diferenciar
%   regiões

% Variável que armazena a probbabilidade de um pixel "x" pertencer a uma
% região 'i' em comparação com uma outra região 'j'
prob_pixel = 0; 


for k=1:Nc
    prob_pixel = (pesos_canal(1,k)*(fdp(regioes(1,1),pixel,k)/(fdp(regioes(1,1),pixel,k)+fdp(regioes(1,2),pixel,k)))) + prob_pixel;
end

peso_geo = 1 - prob_pixel;


end

