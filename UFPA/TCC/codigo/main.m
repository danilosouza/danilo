function [ fdp, img, posicao, resultado_final] = main( imagem, varargin )
%Main Função para segmentar cada componente RGB (ou outro sistema de cores)
%da imagem a ser analisada
%   Esta função recebe como parâmetro a imagens a ser analisada, bem como
%   as imagens marcadas nas regiões de interesse que se deseja segmentar.

img = imread(imagem);
YCBCR = rgb2ycbcr(im2double(img));
[~,~,C] = size(img);
%resultado(N,M,s,r,C) = 0;
resultado_temp = cell(1,C);
for k=1:C
    fprintf('Calculando para a componente %d \n', k);
    profile on
    [fdp, img, posicao,resultado_temp{k}] = segmenta(img(:,:,k), varargin,k, YCBCR);
    %profile viewer
end

[s,~,r,~] = size(fdp);
[N,M,~,~] = size(posicao);
resultado_final(N,M,C,s,r) = 0;

for k=1:C
    resultado_final(:,:,k,:,:) = resultado_temp{k};
    %profile viewer
end

end

