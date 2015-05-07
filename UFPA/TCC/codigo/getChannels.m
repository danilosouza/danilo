function [ bancoFiltros, bancoFDP, respostaFiltros, bancoCanais, Nc ] = getChannels( imagem, arrayPosicao, fator, n_sub_labels,YCBCR )
%UNTITLED4 Fun��o para calcular e retornar os canais da imagem de entrada
%   No artigo principal (Sapiro) s�o utilizados 19 canais:
%       16 filtros de gabor mais os canais Y, Cb, Cr.
%   Recebe como par�metros a imagem original, a largura do filtros e o
%   array NxMxNumero_rabiscos (esse array guarda a posi��o espacial de cada
%   marca��o calculado na fun��o "getPixelsValues" e ser� utilizado para
%   calcular a probabilidade

img = imread(imagem);
%img = imagem;
%if size(img,3) == 3
%    img = rgb2gray(img);
%else
    % A imagem permanece em escala de cinza
%end

[N, M, ~] = size(img);
% Define os �ngulos e frequ�ncias a serem utilizados
angulos = [0 pi/4 pi/2 3*pi/4];
frequencias = [1/2 1/4 1/8 1/16];
% Guarda o n�mero de frequ�ncias e �ngulos. As matrizes criadas
% posteriormente ter�o suas dimens�es em fun��o desses valores para
% facilitar a adi��o de �ngulos e/ou frequ�ncias nas an�lises
[al, ac] = size(angulos);
[fl, fc] = size(frequencias);
Nc = (ac*fc)+3; % N�mero de canais
count = 0;
% Define um impulso unit�tio com origem o centro da matriz [delta(0,0) = 1]
    T = 257; % Tamanho total do impulso
    imp = zeros(T,T);
    imp(round(T/2),round(T/2)) = 1;

% Vari�veis relacionadas ao c�lculo dos canais
janela = 5;
s = floor(janela/2);
alpha = 0.25;
bancoCanais(N,M,Nc) = 0;

% Definindo o impulso
T = 129; % Tamanho total do impulso
imp = zeros(T,T);
imp(round(T/2),round(T/2)) = 1;


% Inserindo os canais fixos no banco de Imagens (Lumin�ncia e 2 de
% cromin�ncia).
YCBCR = rgb2ycbcr(im2double(img));
[~,~,y] = size(YCBCR);
for k=1:y
    bancoCanais(:,:,Nc-(y-k)) = YCBCR(:,:,k);
    bancoCanais(:,:,Nc-(y-k)) = (((bancoCanais(:,:,Nc-(y-k))-min(min(bancoCanais(:,:,Nc-(y-k)))))*255)/(max(max(bancoCanais(:,:,Nc-(y-k))))-min(min(bancoCanais(:,:,Nc-(y-k))))));
end
%bancoCanais(:,:,Nc-2) = YCBCR(:,:,1); % Canal de Lumin�ncia
%bancoCanais(:,:,Nc-1) = YCBCR(:,:,2)*255; % Canal de Cromin�ncia
%bancoCanais(:,:,Nc) = YCBCR(:,:,3)*255; % Canal de Cromin�ncia


% ----- Calculando as vari�veis sigma_x e sigma_y ----- 
S = numel(frequencias); % N�mero de escalas diferentes
K = numel(angulos); % N�mero de dire��es
a = (max(frequencias)/min(frequencias))^(1/(S-1));
sigma_u = ((a-1)*max(frequencias))/((a+1)*sqrt(2*log(2)));
sigma_v = (tan(pi/(2*K))*(max(frequencias) - 2*log((2*(sigma_u^2))/max(frequencias))))/sqrt(2*log(2) - (((2*log(2))^2)*sigma_u^2)/max(frequencias)^2);
sigma_x = 1/(2*pi*sigma_u);
sigma_y = 1/(2*pi*sigma_v);
%}
bancoFiltros((ceil(sigma_x)*fator*2)+1,(ceil(sigma_y)*fator*2)+1,fc*ac) = 0;
%bancoFiltros((sigma*fator*2)+1,(sigma*fator*2)+1,fc*ac) = 0;

% ### Cria��o do banco de filtros para a imagem ###
for i=1:ac
    for j=1:fc
        count = count + 1;
        % Cria o banco de filtros passando a combina��o de frequ�ncias e
        % �ngulos como par�metro
        %bancoFiltros(:,:,count)  = gaborFilter(sigma, angulos(i), frequencias(j), fator);
        bancoFiltros(:,:,count)  = gaborFilter(ceil(sigma_x), ceil(sigma_y), a, angulos(i), frequencias(j), fator, j);
    end
end


% Cria��o do banco de imagens, resultado da filtragem da lumin�ncia da
% imagem original usando os 16 filtros de Gabor.
respostaFiltros(N,M,Nc) = 0;
variancia(Nc,1) = 0;
for k=1:Nc-3
    respostaFiltros(:,:,k) = filter2(bancoFiltros(:,:,k),bancoCanais(:,:,Nc-2));

    % C�lculando a vari�ncia da resposta do filtro de gabor
    variancia(k,1) = var(var(respostaFiltros(:,:,k)));
end

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
            bancoCanais(i,j,k) = (soma/(janela^2));
        end
    end
    bancoCanais(:,:,k) = (((bancoCanais(:,:,k)-min(min(bancoCanais(:,:,k))))*255)/(max(max(bancoCanais(:,:,k)))-min(min(bancoCanais(:,:,k)))));
end

% ### C�lculo da FPD dos pixels marcados para cada canal ###
%[~,~,~,~] = size(arrayPosicao);
%bancoFDP(t,256,w,Nc) = 0;

for k=1:Nc
    bancoFDP(:,:,:,k) = getPixelsDist(arrayPosicao, bancoCanais(:,:,k), n_sub_labels);
end
%}

end

