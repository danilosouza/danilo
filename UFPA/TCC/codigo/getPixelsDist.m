function [ y ] = getPixelsDist( arrayPosicao, imagem )
%getPixelsDist Fun��o para retornar a FDP dos pixels
%   Essa fun��o � similar a fun��o "getPixelsValues", por�m recebe como
% entrada o canal que se deseja calcular as FDP's e um array 3-D que guarda
% a posi��o dos pixels marcados para cada regi�o de interesse.

[N,M,t] = size(arrayPosicao);
%pixelsValues(t,count) = 0;

for k=1:t
    count = 0;
    for i=1:N
        for j=1:M
            if arrayPosicao(i,j,k) ~= 0
            count = count + 1;
            pixelsValues(k,count) = imagem(i,j); 
            end
        end
    end
end

% ----- C�lculo da FDP usando a fun��o "fitdist" -----
%Adequa o vetor com os pixels de uma regi�o de interesse para o c�lculo da FDP
pixelsValues = pixelsValues';
x_values = 0:1:255;
str(t,9) = 0;
y(t,256) = 0;   
for k=1:t
    pd = fitdist(pixelsValues(:,k),'Normal');
    % Calcula a FDP dos pixels de uma regi�o de interesse
    y(k,:) = pdf(pd,x_values);
    str(k,:) = sprintf('p_{%d}^{i}', k);
end

end

