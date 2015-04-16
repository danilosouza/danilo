function [ peso_geo ] = getGeodesicWeight( fdp, regioes, Nc, pesos_canal,pixel )
%getGeodesicWeight Fun��o que calcula o peso associado com a dist�ncia
%geod�sica, baseado na probabilidade de um determinado pixel pertencer a
%uma dada regi�o de interesse
%   Essa fun��o recebe como par�metro a FDP de todas as regi�es de
%   interesse e as regi�es de interesse para qual o peso est� sendo
%   calculado. A probabilidade calculada � a de um pixels pertencer a uma
%   dada regi�o. A fun��o
%   recebe tamb�m o peso dos canais para realizar o c�lculo das
%   probabilidades em fun��o da capacidade de cada canal em diferenciar
%   regi�es

% Vari�vel que armazena a probbabilidade de um pixel "x" pertencer a uma
% regi�o 'i' em compara��o com uma outra regi�o 'j'
prob_pixel = 0; 


for k=1:Nc
    prob_pixel = (pesos_canal(1,k)*(fdp(regioes(1,1),pixel,k)/(fdp(regioes(1,1),pixel,k)+fdp(regioes(1,2),pixel,k)))) + prob_pixel;
end

peso_geo = 1 - prob_pixel;


end

