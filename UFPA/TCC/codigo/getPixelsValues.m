function [ img_scribbled, mat_img, vetor, y ] = getPixelsValues( imagem, varargin)
%getPixels Fun��o para recuperar os pixels marcados nas regi�es de
%interesse da imagem a ser segmentada
%   Detailed explanation goes here
%   Esta fun��o recupera os pixels dos "rabiscos" das regi�es de interesse
%   de uma imagem. Para isso � necess�rio passar como par�metro uma imagem
%   com cada regi�o de interesse marcada separadamente. Exemplo, se uma
%   imagem possui 3 regi�es de interesse, � necess�rio passar 3 imagens
%   diferentes onde cada imagem possui uma marca��o em cada uma das regi�es
%   de interesse. As imagens devem estar no formato ".png" para que n�o
%   haja mudan�a nos valores dos pixels quando a imagem for salva.
%Par�metros da fun��o getPixels( imagem, num_scribbles, imagem_scribbled)

img = imread(imagem);

if size(img,3) == 3
    img = rgb2gray(img);
end
[N,M,~] = size(img);
% Matriz que vai armazenar cada imagem com os scribbles separados
mat_img(N,M,nargin-1) = 0;
% Array que armazena temporariamente as imagens "rabiscadas"
img_scribbled_temp = cell(1,nargin-1);
% Matriz que armazena as imagens "rabiscadas" para compara��o com a imagem
% original
img_scribbled(N,M,nargin-1) = 0;
%scb = imread(imagem_scribbled);

% Armazena aas imagens "rabiscadas" em um vetor c�lula
for k=1:nargin-1
    img_scribbled_temp{k} = imread(varargin{k});
    % Converte a imagem para escala de cinza para facilitar a transforma��o
    % de array em matriz (para que a imagem n�o fique tri-dimensional)
    img_scribbled_temp{k} = rgb2gray(img_scribbled_temp{k});
end

% Armazena as imagens na amtriz definitiva
for k=1:nargin-1
    img_scribbled(:,:,k) = img_scribbled_temp{k};
end
   
vetor = 0;

%Compara a imagem original com a imagem "rabiscada" e armazena os pixels de
%cada "rabisco" em um vetor
for k=1:nargin-1
    count = 0;
    for i=1:N
        for j=1:M
            if img(i,j) ~= img_scribbled(i,j,k);
                count = count + 1;
                vetor(k,count) = img_scribbled(i,j,k);
                mat_img(i,j,k) = img_scribbled(i,j,k);
            end
        end
    end
end

%Adequa o vetor com os pixels de uma regi�o de interesse para o c�lculo da FDP
vetor = vetor';
x_values = 0:1:255;
for k=1:nargin-1
    pd = fitdist(vetor(:,k),'Normal');
    % Calcula a FDP dos pixels de uma regi�o de interesse
    y(k,:) = pdf(pd,x_values);
    str(k,:) = sprintf('p_{%d}^{i}', k);
end
plot(x_values,y,'LineWidth',2);legend(str);
end

