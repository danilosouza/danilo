function [ filtro ] = gaborFilter(largura, theta, omega)
%UNTITLED5 
%   Fun��o que calcula os valores do filtro da Gabor sobre os 
%   par�metros de entradade entrada
%   Seus par�metros de entrada s�o: a largura do
%   filtro no fomato [x y], o �ngulo ddesejado e a frequ�ncia desejada
sigma_x = largura(1,1);
sigma_y = largura(1,2);
filtro(sigma_x,sigma_y) = 0;
% C�lculo do filtro usando a f�rmula descrita no artigo.
gb1 = 2*pi*sigma_x*sigma_y;
for k=1:sigma_x
    for j=1:sigma_y
        X = k*cos(theta)+j*sin(theta);
        Y = -k*sin(theta)+j*cos(theta);
        gb2 = -0.5*((X^2/sigma_x^2)+(Y^2/sigma_y^2)) + 2*pi*omega*1i*X;
        gb = exp(gb2)/gb1;
        gb = real(gb);
        filtro(k,j) = gb;
    end
end

end

