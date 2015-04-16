function [ bancoFiltros, bancoFDP, respostaFiltros, bancoCanais, Nc ] = getChannels( imagem, arrayPosicao, fator )
%UNTITLED4 Função para calcular e retornar os canais da imagem de entrada
%   No artigo principal (Sapiro) são utilizados 19 canais:
%       16 filtros de gabor mais os canais Y, Cb, Cr.
%   Recebe como parâmetros a imagem original, a largura do filtros e o
%   array NxMxNumero_rabiscos (esse array guarda a posição espacial de cada
%   marcação calculado na função "getPixelsValues" e será utilizado para
%   calcular a probabilidade

img = imread(imagem);
%if size(img,3) == 3
%    img = rgb2gray(img);
%else
    % A imagem permanece em escala de cinza
%end

[N, M, ~] = size(img);
% Define os ângulos e frequências a serem utilizados
angulos = [0 pi/4 pi/2 3*pi/4];
frequencias = [1/2 1/4 1/8 1/16];
% Guarda o número de frequências e ângulos. As matrizes criadas
% posteriormente terão suas dimensões em função desses valores para
% facilitar a adição de ângulos e/ou frequências nas análises
[al, ac] = size(angulos);
[fl, fc] = size(frequencias);
Nc = (ac*fc)+3; % Número de canais
count = 0;
% Define um impulso unitátio com origem o centro da matriz [delta(0,0) = 1]
    T = 257; % Tamanho total do impulso
    imp = zeros(T,T);
    imp(round(T/2),round(T/2)) = 1;

% Variáveis relacionadas ao cálculo dos canais
janela = 5;
s = floor(janela/2);
alpha = 0.25;
bancoCanais(N,M,Nc) = 0;

% Definindo o impulso
T = 129; % Tamanho total do impulso
imp = zeros(T,T);
imp(round(T/2),round(T/2)) = 1;


% Inserindo os canais fixos no banco de Imagens (Luminância e 2 de
% crominância).
YCBCR = rgb2ycbcr(im2double(img));
bancoCanais(:,:,Nc-2) = YCBCR(:,:,1)*255; % Canal de Luminância
bancoCanais(:,:,Nc-1) = YCBCR(:,:,2)*255; % Canal de Crominância
bancoCanais(:,:,Nc) = YCBCR(:,:,3)*255; % Canal de Crominância


resolucao = 256;
%a(ac*fc,resolucao) = 0;
%f(resolucao,ac*fc) = 0;


% ----- Calculando as variáveis sigma_x e sigma_y ----- 
S = numel(frequencias); % Número de escalas diferentes
K = numel(angulos); % Número de direções
a = (max(frequencias)/min(frequencias))^(1/(S-1));
sigma_u = ((a-1)*max(frequencias))/((a+1)*sqrt(2*log(2)));
sigma_v = (tan(pi/(2*K))*(max(frequencias) - 2*log((2*(sigma_u^2))/max(frequencias))))/sqrt(2*log(2) - (((2*log(2))^2)*sigma_u^2)/max(frequencias)^2);
sigma_x = 1/(2*pi*sigma_u);
sigma_y = 1/(2*pi*sigma_v);
%}
bancoFiltros((ceil(sigma_x)*fator*2)+1,(ceil(sigma_y)*fator*2)+1,fc*ac) = 0;
%bancoFiltros((sigma*fator*2)+1,(sigma*fator*2)+1,fc*ac) = 0;
% ### Criação do banco de filtros para a imagem ###
for i=1:ac
    for j=1:fc
        count = count + 1;
        % Cria o banco de filtros passando a combinação de frequências e
        % ângulos como parâmetro
        %bancoFiltros(:,:,count)  = gaborFilter(sigma, angulos(i), frequencias(j), fator);
        bancoFiltros(:,:,count)  = gaborFilter(ceil(sigma_x), ceil(sigma_y), a, angulos(i), frequencias(j), fator, j);
        
        % --- Plots das respostas em frequências dos filtros ---
        %{
        h = conv2(bancoFiltros(:,:,count),imp);
         Calcula a transformada de Fourier de h(x,y) = H(u,v) (Resposta em
         frequência do filtro
        H = fftshift(h,resolucao);
        [A, F] = freqz2(H,[1 resolucao]);
        a(count,:) = real(A);
        f(:,count) = F;
        %}
    end
    %{
    % Plot das resposta em frequências combinados por direção
    str_i1 = sprintf('Resposta em Frequência do filtro \\theta = %.1fº e w = %.4f', angulos(i)*180/pi, frequencias(1));
    str_i2 = sprintf('Resposta em Frequência do filtro \\theta = %.1fº e w = %.4f', angulos(i)*180/pi, frequencias(2));
    str_i3 = sprintf('Resposta em Frequência do filtro \\theta = %.1fº e w = %.4f', angulos(i)*180/pi, frequencias(3));
    str_i4 = sprintf('Resposta em Frequência do filtro \\theta = %.1fº e w = %.4f', angulos(i)*180/pi, frequencias(4));
    figure;
    % Plota as imagens com os 4 ângulos para cada frequência
    subplot(2,2,1);plot(f(:,count-3),10*log10(abs(a(count-3,:))));title(str_i1);
    subplot(2,2,2);plot(f(:,count-2),10*log10(abs(a(count-2,:))));title(str_i2);
    subplot(2,2,3);plot(f(:,count-1),10*log10(abs(a(count-1,:))));title(str_i3);
    subplot(2,2,4);plot(f(:,count),10*log10(abs(a(count,:))));title(str_i4);
    %}
    %{
    % ----- Plot's das imagens -----
    % Filtragem da imagem original usando os 4 filtros (com ângulos
    % diferentes) por frequência e armazena em imagens temporárias
    i1 = filter2(bancoFiltros(:,:,count-3),rgb2gray(img));
    str_i1 = sprintf('Imagem filtrada com theta = %.4f rad e w = %.4f', angulos(1), frequencias(i));
    i2 = filter2(bancoFiltros(:,:,count-2),rgb2gray(img));
    str_i2 = sprintf('Imagem filtrada com theta = %.4f rad e w = %.4f', angulos(2), frequencias(i));
    i3 = filter2(bancoFiltros(:,:,count-1),rgb2gray(img));
    str_i3 = sprintf('Imagem filtrada com theta = %.4f rad e w = %.4f', angulos(3), frequencias(i));
    i4 = filter2(bancoFiltros(:,:,count),rgb2gray(img));
    str_i4 = sprintf('Imagem filtrada com theta = %.4f rad e w = %.4f', angulos(4), frequencias(i));
    figure;
    % Plota as imagens com os 4 ângulos para cada frequência
    subplot(3,2,1);imshow(img,[]);title('Imagem orginal');
    str_soma = sprintf('Soma das 4 imagens filtradas com w = %.4f', frequencias(i));
    subplot(3,2,2);imshow(i1+i2+i3+i4);title(str_soma);
    subplot(3,2,3);imshow(i1);title(str_i1);
    subplot(3,2,4);imshow(i2);title(str_i2);
    subplot(3,2,5);imshow(i3);title(str_i3);
    subplot(3,2,6);imshow(i4);title(str_i4);
    %}
end


% Criação do banco de imagens, resultado da filtragem da luminância da
% imagem original usando os 16 filtros de Gabor.
respostaFiltros(N,M,Nc) = 0;
variancia(Nc,1) = 0;
for k=1:Nc-3
    respostaFiltros(:,:,k) = filter2(bancoFiltros(:,:,k),bancoCanais(:,:,Nc-2));
    %respostaFiltros(:,:,k) = filter2(bancoFiltros(:,:,k),-respostaFiltros(:,:,k));
    respostaFiltros(:,:,k) = respostaFiltros(:,:,k)*255;
    % Cálculando a variância da resposta do filtro de gabor
    variancia(k,1) = var(var(respostaFiltros(:,:,k)));
end

% ### Criação dos canais seguindo a fórmula apresentada no artigo. ###
for k=1:Nc-3
    respostaFiltros(:,:,k) = 255*tanh((respostaFiltros(:,:,k)/sqrt(variancia(k,1)))*alpha);
    for i=1+s:N-s
        for j=1+s:M-s
            % Loop para percorrer a janela NxN a cada novo pixel da imagem
            soma = 0;
            for n=i-s:i+s
                for m=j-s:j+s
                    soma = soma + respostaFiltros(n,m,k);
                end
            end
            bancoCanais(i,j,k) = (soma/(janela^2));
        end
    end
    bancoCanais(:,:,k) = ((bancoCanais(:,:,k)-min(min(bancoCanais(:,:,k))))/(max(max(bancoCanais(:,:,k)))-min(min(bancoCanais(:,:,k))))) * 255;
end

% ### Cálculo da FPD dos pixels marcados para cada canal ###
[~,~,t] = size(arrayPosicao);
bancoFDP(t,256,Nc) = 0;
for k=1:Nc
    bancoFDP(:,:,k) = getPixelsDist(arrayPosicao, bancoCanais(:,:,k));
end
%}

end

