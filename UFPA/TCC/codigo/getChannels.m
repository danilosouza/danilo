function [ bancoFiltros, bancoFDP, respostaFiltros, bancoCanais ] = getChannels( imagem, sigma, arrayPosicao, fator )
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
% Define os �ngulos e frequ�ncias a serem utilizados
angulos = [0 pi/4 pi/2 3*pi/4];
frequencias = [ 1/2 1/4 1/8 1/16];
% Guarda o n�mero de frequ�ncias e �ngulos. As matrizes criadas
% posteriormente ter�o suas dimens�es em fun��o desses valores para
% facilitar a adi��o de �ngulos e/ou frequ�ncias nas an�lises
[al, ac] = size(angulos);
[fl, fc] = size(frequencias);
Nc = (ac*fc)+3; % N�mero de canais
count = 0;
bancoFiltros((sigma*fator*2)+1,(sigma*fator*2)+1,fc*ac) = 0;
bancoCanais(N,M,Nc) = 0;

% Definindo o impulso
T = 129; % Tamanho total do impulso
imp = zeros(T,T);
imp(round(T/2),round(T/2)) = 1;


% Inserindo os canais fixos no banco de Imagens (Lumin�ncia e 2 de
% cromin�ncia).
YCBCR = rgb2ycbcr(im2double(img));
bancoCanais(:,:,Nc-2) = YCBCR(:,:,1)*255; % Canal de Lumin�ncia
bancoCanais(:,:,Nc-1) = YCBCR(:,:,2)*255; % Canal de Cromin�ncia
bancoCanais(:,:,Nc) = YCBCR(:,:,3)*255; % Canal de Cromin�ncia

a(16,128) = 0;
f(128,16) = 0;
% ### Cria��o do banco de filtros para a imagem ###
for i=1:ac
    for j=1:fc
        count = count + 1;
        % Cria o banco de filtros passando a combina��o de frequ�ncias e
        % �ngulos como par�metro
        bancoFiltros(:,:,count)  = gaborFilter(sigma, angulos(i), frequencias(j), fator);
        % --- Plots das respostas em frequ�ncias dos filtros ---
        h = conv2(bancoFiltros(:,:,count),imp);
        % Calcula a transformada de Fourier de h(x,y) = H(u,v) (Resposta em
        % frequ�ncia do filtro
        H = fftshift(h,128);
        [A, F] = freqz2(H,[1 128]);
        a(count,:) = real(A);
        f(:,count) = F;
    end
    % Plot das resposta em frequ�ncias combinados por dire��o
    str_i1 = sprintf('Resposta em Frequ�ncia do filtro \\theta = %.1f� rad e w = %.4f', angulos(i)*180/pi, frequencias(1));
    str_i2 = sprintf('Resposta em Frequ�ncia do filtro \\theta = %.1f� rad e w = %.4f', angulos(i)*180/pi, frequencias(2));
    str_i3 = sprintf('Resposta em Frequ�ncia do filtro \\theta = %.1f� rad e w = %.4f', angulos(i)*180/pi, frequencias(3));
    str_i4 = sprintf('Resposta em Frequ�ncia do filtro \\theta = %.1f� rad e w = %.4f', angulos(i)*180/pi, frequencias(4));
    figure;
    % Plota as imagens com os 4 �ngulos para cada frequ�ncia
    subplot(2,2,1);plot(f(:,count-3),10*log10(abs(a(count-3,:))));title(str_i1);
    subplot(2,2,2);plot(f(:,count-2),10*log10(abs(a(count-2,:))));title(str_i2);
    subplot(2,2,3);plot(f(:,count-1),10*log10(abs(a(count-1,:))));title(str_i3);
    subplot(2,2,4);plot(f(:,count),10*log10(abs(a(count,:))));title(str_i4);

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








% Cria��o do banco de imagens, resultado da filtragem da lumin�ncia da
% imagem original usando os 16 filtros de Gabor.
respostaFiltros(N,M,Nc) = 0;
variancia(Nc,1) = 0;
for k=1:Nc-3
    respostaFiltros(:,:,k) = filter2(bancoFiltros(:,:,k),bancoCanais(:,:,Nc-2));
    %respostaFiltros(:,:,k) = respostaFiltros(:,:,k)*255;
    % C�lculando a vari�ncia da resposta do filtro ao canal de lumin�ncia
    variancia(k,1) = var(var(respostaFiltros(:,:,k)));
end

% C�lculo dos canais
janela = 5;
s = floor(janela/2);
alpha = 0.25;

% ### Cria��o dos canais seguindo a f�rmula apresentada no artigo. ###
for k=1:Nc-3
    respostaFiltros(:,:,k) = tanh((respostaFiltros(:,:,k)/sqrt(variancia(k,1)))*alpha);
    for i=1+s:N-s
        for j=1+s:M-s
            % Loop para percorrer a janela NxN a cada novo pixel da imagem
            soma = 0;
            for n=i-s:i+s
                for m=j-s:j+s
                    soma = soma + respostaFiltros(n,m,k);
                end
            end
            bancoCanais(i,j,k) = (soma/(janela^2))*255;
        end
    end
end

% ### C�lculo da FPD dos pixels marcados para cada canal ###
[~,~,t] = size(arrayPosicao);
bancoFDP(t,256,Nc) = 0;
for k=1:Nc
    bancoFDP(:,:,k) = getPixelsDist(arrayPosicao, bancoCanais(:,:,k));
end


end

