function [ peso_canal ] = getChannelWeight( fdp, Nc, canal )
%getWeight Calcula o peso de cada canal
%   Essa fun��o recebe como par�metro uma matriz com as FDP's de todos as
%   regi�es de interesse para cada canal e a partir desses valores
%   encontrar a fun��o m�nimo para cada canal e ent�o calcula o peso do
%   canal. Recebe tamb�m o canal atual que se est� calculando o peso, para
%   saber de qual canal dever� utilizar a FDP

% --- Encontrar o m�nimo das FDP's de cada canal ---
minimo(Nc,256) = 0; % Vetor que armazena o m�nimo das FDP's de cada canal
P_min(1,Nc) = 0;
[r,~,~] = size(fdp);
for i=1:Nc
    for j=1:256
        fdp_temp = fdp(:,:,i);
        minimo(i,j) = min(fdp_temp(:,j));
    end
    P_min(1,i) = (1/r)*sum(minimo(i,:));
end

% --- C�lculo do peso de cada canal


P_min_soma = sum(1./P_min);

peso_canal = (1/P_min(1,canal))/P_min_soma;


end

