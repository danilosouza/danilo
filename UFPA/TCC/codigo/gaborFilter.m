function [ filtro ] = gaborFilter(sigma, theta, omega, fator)
%UNTITLED5 
%   Fun��o que calcula os valores do filtro da Gabor sobre os 
%   par�metros de entradade entrada
%   Seus par�metros de entrada s�o: o desvio padr�o,
%   o �ngulo e a frequ�ncia desejados e o fator que multiplica o desvio
%   padr�o para definir o tamanho da janela do filtro

% Fator que multiplica o desvio padr�o e indica o tamanho da janela do
% filtro
% Declara��o do filtro
filtro((sigma*fator*2)+1,(sigma*fator*2)+1) = 0;
% C�lculo do filtro usando a f�rmula descrita no artigo.
gb1 = 2*pi*sigma*sigma;
for k=1:(sigma*fator*2)+1
    for j=1:(sigma*fator*2)+1
        X = k*cos(theta)+j*sin(theta);
        Y = -k*sin(theta)+j*cos(theta);
        gb2 = -0.5*((X^2/sigma^2)+(Y^2/sigma^2)) + 2*pi*omega*1i*X;
        gb = exp(gb2)/gb1;
        gb = real(gb);
        filtro(k,j) = gb;
    end
end

end

