function [ bancoFiltros ] = getChannels( imagem, largura )
%UNTITLED4 Função para calcular e retornar os canais da imagem de entrada
%   No artigo principal (Sapiro) são utilizados 19 canais:
%       16 filtros de gabor mais YCbCr

img = imread(imagem);
%Nc = 19; % Número de canais
bancoFiltros(largura(1,1),largura(1,2),16) = 0;
angulos = [0 pi/4 pi/2 3*pi/2];
frequencias = [1/2 1/4 1/8 1/16];
count = 0;
for i=1:4
    for j=1:4
        count = count + 1;
        bancoFiltros(:,:,count)  = gaborFilter(largura, angulos(i), frequencias(j));
    end
end




end

