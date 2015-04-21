function [ peso_canal ] = getChannelWeight( fdp, Nc, canal )
%getWeight Calcula o peso de cada canal
%   Essa fun��o recebe como par�metro uma matriz com as FDP's de todos as
%   regi�es de interesse para cada canal e a partir desses valores
%   encontrar a fun��o m�nimo para cada canal e ent�o calcula o peso do
%   canal. Recebe tamb�m o canal atual que se est� calculando o peso, para
%   saber de qual canal dever� utilizar a FDP

% --- Encontrar o m�nimo das FDP's de cada canal ---
[s,~,r,~] = size(fdp);
% Vetor que armazena o m�nimo das FDP's de cada canal
minimo(Nc,256) = 0;
% Vetor que armazena o m�nimo das FDP's de cada regi�o
fdp_regiao(r,256) = 0;

P_min(1,Nc) = 0;
P_min_regiao(1,r) = 0;

for i=1:Nc
    for k=1:r
        fdp_temp = fdp(:,:,k,i);
        % Varifica quantas subregi�es a regi�o atual possui e elimina
        % os zeros da matriz FDP
        for b=1:s
            if fdp_temp(b,:) == 0
                fdp_temp(b,:) = [];
            else

            end   
        end
        fdp_regiao(k,:) = sum(fdp_temp(:,:));
    end
    minimo(i,:) = min(fdp_regiao(:,:));
    P_min(1,i) = (1/r)*sum(minimo(i,:));
end

% --- C�lculo do peso de cada canal


P_min_soma = sum(1./P_min);

peso_canal = (1/P_min(1,canal))/P_min_soma;


end

