function [ filtro ] = gaborFilter(sigma_x, sigma_y, a, theta, omega, fator,j)
%UNTITLED5 
%   Fun��o que calcula os valores do filtro da Gabor sobre os 
%   par�metros de entradade entrada
%   Seus par�metros de entrada s�o: o desvio padr�o,
%   o �ngulo e a frequ�ncia desejados e o fator que multiplica o desvio
%   padr�o para definir o tamanho da janela do filtro

% Fator que multiplica o desvio padr�o e indica o tamanho da janela do
% filtro
% Declara��o do filtro
%largura = (sigma*fator*2)+1; 
%filtro(largura,largura) = 0;
filtro((ceil(sigma_x)*fator*2)+1,(ceil(sigma_y)*fator*2)+1) = 0;
[N, M] = size(filtro);
m = j-1;
gb1 = 1/(2*pi*sigma_x*sigma_y);
for k=1:N
    for j=1:M
        % C�lculo considerando as f�rmulas do artigo 15
        X = a^(-m)*(k*cos(theta)+j*sin(theta));
        Y = a^(-m)*(-k*sin(theta)+j*cos(theta));
        gb2 = -0.5*((X^2/sigma_x^2)+(Y^2/sigma_y^2)) + 2*pi*omega*1i*X;

        gb = gb1*exp(gb2);
        gb = real(gb);
        filtro(k,j) = (a^(-m))*gb;
    end
end

end

