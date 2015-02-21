function [ img_scribbled, mat_img, vetor, y ] = getPixels( imagem, num_scribbles, varargin)
%getPixels Função para recuperar os pixels marcados nas regiões de
%interesse da imagem a ser segmentada
%   Detailed explanation goes here
%   Esta função recupera os pixels dos "rabiscos" das regiões de interesse
%   de uma imagem. Para isso é necessário passar como parâmetro uma imagem
%   com cada região de interesse marcada separadamente. Exemplo, se uma
%   imagem possui 3 regiões de interesse, é necessário passar 3 imagens
%   diferentes onde cada imagem possui uma marcação em cada uma das regiões
%   de interesse.
%Parâmetros da função getPixels( imagem, num_scribbles, imagem_scribbled)

img = imread(imagem);
[N,M,~] = size(img);
% Matriz que vai armazenar cada imagem com os scribbles separados
mat_img(N,M,num_scribbles) = 0;
% Array que armazena temporariamente as imagens "rabiscadas"
img_scribbled_temp = cell(1,0,nargin-2);
% Matriz que armazena as imagens "rabiscadas" para comparação com a imagem
% original
img_scribbled(N,M,num_scribbles) = 0;
%scb = imread(imagem_scribbled);

% Armazena aas imagens "rabiscadas" em um vetor célula
for k=1:nargin-2
    img_scribbled_temp{k} = imread(varargin{k});
    % Converte a imagem para escala de cinza para facilitar a transformação
    % de array em matriz (para que a imagem não fique tri-dimensional)
    img_scribbled_temp{k} = rgb2gray(img_scribbled_temp{k});
end

% Armazena as imagens na amtriz definitiva
for k=1:nargin-2
    img_scribbled(:,:,k) = img_scribbled_temp{k};
end
   
vetor = 0;

%Compara a imagem original com a imagem "rabiscada" e armazena os pixels de
%cada "rabisco" em um vetor
for k=1:nargin-2
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

%Adequa o vetor com os pixels de uma região de interesse para o cálculo da FDP
vetor = vetor';
for k=1:nargin-2
    pd = fitdist(vetor(:,k),'Normal');
    % Calcula a FDP dos pixels de uma região de interesse
    y(k,:) = pdf(pd,1:1:256);
end
%plot(1:1:256,y,'LineWidth',2);
end

