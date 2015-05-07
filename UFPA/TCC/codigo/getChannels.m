function [ bancoFiltros, bancoFDP, respostaFiltros, bancoCanais, Nc ] = getChannels( imagem, arrayPosicao, fator, n_sub_labels,YCBCR )
%UNTITLED4 Função para calcular e retornar os canais da imagem de entrada
%   No artigo principal (Sapiro) são utilizados 19 canais:
%       16 filtros de gabor mais os canais Y, Cb, Cr.
%   Recebe como parâmetros a imagem original, a largura do filtros e o
%   array NxMxNumero_rabiscos (esse array guarda a posição espacial de cada
%   marcação calculado na função "getPixelsValues" e será utilizado para
%   calcular a probabilidade

img = imread(imagem);
%img = imagem;
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
[~,~,y] = size(YCBCR);
for k=1:y
    bancoCanais(:,:,Nc-(y-k)) = YCBCR(:,:,k);
    bancoCanais(:,:,Nc-(y-k)) = (((bancoCanais(:,:,Nc-(y-k))-min(min(bancoCanais(:,:,Nc-(y-k)))))*255)/(max(max(bancoCanais(:,:,Nc-(y-k))))-min(min(bancoCanais(:,:,Nc-(y-k))))));
end
%bancoCanais(:,:,Nc-2) = YCBCR(:,:,1); % Canal de Luminância
%bancoCanais(:,:,Nc-1) = YCBCR(:,:,2)*255; % Canal de Crominância
%bancoCanais(:,:,Nc) = YCBCR(:,:,3)*255; % Canal de Crominância


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
    end
end


% Criação do banco de imagens, resultado da filtragem da luminância da
% imagem original usando os 16 filtros de Gabor.
respostaFiltros(N,M,Nc) = 0;
variancia(Nc,1) = 0;
for k=1:Nc-3
    respostaFiltros(:,:,k) = filter2(bancoFiltros(:,:,k),bancoCanais(:,:,Nc-2));

    % Cálculando a variância da resposta do filtro de gabor
    variancia(k,1) = var(var(respostaFiltros(:,:,k)));
end

% ### Criação dos canais seguindo a fórmula apresentada no artigo. ###
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
            bancoCanais(i,j,k) = (soma/(janela^2));
        end
    end
    bancoCanais(:,:,k) = (((bancoCanais(:,:,k)-min(min(bancoCanais(:,:,k))))*255)/(max(max(bancoCanais(:,:,k)))-min(min(bancoCanais(:,:,k)))));
end

% ### Cálculo da FPD dos pixels marcados para cada canal ###
%[~,~,~,~] = size(arrayPosicao);
%bancoFDP(t,256,w,Nc) = 0;

for k=1:Nc
    bancoFDP(:,:,:,k) = getPixelsDist(arrayPosicao, bancoCanais(:,:,k), n_sub_labels);
end
%}

end

