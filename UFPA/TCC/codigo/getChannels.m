function [ bancoFiltros, bancoFDP, respostaFiltros ] = getChannels( imagem, sigma, arrayPosicao, fator )
%UNTITLED4 Fun��o para calcular e retornar os canais da imagem de entrada
%   No artigo principal (Sapiro) s�o utilizados 19 canais:
%       16 filtros de gabor mais os canais Y, Cb, Cr.
%   Recebe como par�metros a imagem original, a largura do filtros e o
%   array NxMxNumero_rabiscos (esse array guarda a posi��o espacial de cada
%   marca��o calculado na fun��o "getPixelsValues" e ser� utilizado para
%   calcular a probabilidade

img = imread(imagem);
%if size(img,3) == 3
%    img = rgb2gray(img);
%else
    % A imagem permanece em escala de cinza
%end

[N, M, ~] = size(img);
Nc = 19; % N�mero de canais
bancoFiltros((sigma*fator*2)+1,(sigma*fator*2)+1,16) = 0;
% Define os �ngulos e frequ�ncias a serem utilizados
angulos = [0 pi/4 pi/2 3*pi/4];
frequencias = [1/2 1/4 1/8 1/16];
count = 0;
% --- C�lculo do banco de filtros para a imagem ---
for i=1:4
    for j=1:4
        count = count + 1;
        % Cria o banco de filtros passando a combina��o de frequ�ncias e
        % �ngulos como par�metro
        bancoFiltros(:,:,count)  = gaborFilter(sigma, angulos(j), frequencias(i), fator);
    end
    %{
    % ----- Plot's das imagens -----
    % Filtragem da imagem original usando os 4 filtros (com �ngulos
    % diferentes) por frequ�ncia e armazena em imagens tempor�rias
    i1 = filter2(bancoFiltros(:,:,count-3),rgb2gray(img));
    str_i1 = sprintf('Imagem filtrada com theta = %.4f rad e w = %.4f', angulos(1), frequencias(i));
    i2 = filter2(bancoFiltros(:,:,count-2),rgb2gray(img));
    str_i2 = sprintf('Imagem filtrada com theta = %.4f rad e w = %.4f', angulos(2), frequencias(i));
    i3 = filter2(bancoFiltros(:,:,count-1),rgb2gray(img));
    str_i3 = sprintf('Imagem filtrada com theta = %.4f rad e w = %.4f', angulos(3), frequencias(i));
    i4 = filter2(bancoFiltros(:,:,count),rgb2gray(img));
    str_i4 = sprintf('Imagem filtrada com theta = %.4f rad e w = %.4f', angulos(4), frequencias(i));
    figure;
    % Plota as imagens com os 4 �ngulos para cada frequ�ncia
    subplot(3,2,1);imshow(img,[]);title('Imagem orginal');
    str_soma = sprintf('Soma das 4 imagens filtradas com w = %.4f', frequencias(i));
    subplot(3,2,2);imshow(i1+i2+i3+i4);title(str_soma);
    subplot(3,2,3);imshow(i1);title(str_i1);
    subplot(3,2,4);imshow(i2);title(str_i2);
    subplot(3,2,5);imshow(i3);title(str_i3);
    subplot(3,2,6);imshow(i4);title(str_i4);
    %}
end

% Inserindo os canais fixos no banco de Imagens (Lumin�ncia e 2 de
% cromin�ncia).
YCBCR = rgb2ycbcr(im2double(img));
bancoCanais(:,:,17) = YCBCR(:,:,1); % Canal de Lumin�ncia
bancoCanais(:,:,18) = YCBCR(:,:,2); % Canal de Cromin�ncia
bancoCanais(:,:,19) = YCBCR(:,:,3); % Canal de Cromin�ncia


% Cria��o do banco de imagens, resultado da filtragem da lumin�ncia da
% imagem original usando os 16 filtros de Gabor.
respostaFiltros(N,M,16) = 0;
variancia(Nc,1) = 0;
for k=1:Nc-3
    respostaFiltros(:,:,k) = filter2(bancoFiltros(:,:,k),bancoCanais(:,:,17));
    respostaFiltros(:,:,k) = respostaFiltros(:,:,k)*255;
    % C�lculando a vari�ncia da resposta do filtro ao canal de lumin�ncia
    variancia(k,1) = var(var(respostaFiltros(:,:,k)));
end

% C�lculo dos canais
bancoCanais(N,M,Nc) = 0;
janela = 5;
alpha = 0.25;

% Cria��o dos canais seguindo a f�rmula apresentada no artigo.
for k=1:Nc-3
    for i=N:1
        for j=1:M
            %bancoCanais(i,j,k) = 
        end
    end
end

% C�lculo
for k=1:Nc
    bancoFDP(:,:,k) = getPixelsDist(arrayPosicao, bancoCanais(:,:,k));
end


end

