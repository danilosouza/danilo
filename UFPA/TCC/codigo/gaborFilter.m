function [ filtro ] = gaborFilter(largura, theta, omega)
%UNTITLED5 
%   Função que calcula os valores do filtro da Gabor sobre os 
%   parâmetros de entradade entrada
%   Seus parâmetros de entrada são: a largura do
%   filtro no fomato [x y], o ângulo ddesejado e a frequência desejada
sigma_x = largura(1,1);
sigma_y = largura(1,2);
filtro(sigma_x,sigma_y) = 0;
% Cálculo do filtro usando a fórmula descrita no artigo.
gb1 = 2*pi*sigma_x*sigma_y;
for i=1:sigma_x
    for j=1:sigma_y
        X = i*cos(theta)+j*sin(theta);
        Y = -i*sin(theta)+j*cos(theta);
        gb2 = -0.5*((X^2/sigma_x^2)+(Y^2/sigma_y^2)) + 2*pi*omega*1i*X;
        gb = exp(gb2)/gb1;
        gb = real(gb);
        filtro(i,j) = gb;
    end
end

end

