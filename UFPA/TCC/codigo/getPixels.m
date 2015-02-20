function [ vetor, mat, count ] = getPixels(varargin)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%Parâmetros da função getPixels( imagem, num_scribbles, imagem_scribbled)

img = imread(varargin{1});
[N,M,~] = size(img);
% Matriz que vai armazenar cada imagem com os scribbles separados
mat_img(N,M,varargin{2}) = 0;


%scb = imread(imagem_scribbled);

for k=3:nargin
    for i=1:N
        for j=1:M
            mat_img(i,j,k) = varargin{k}(i,j);    
        end
    end
end
    

%vetor = 0;
%mat(N,M) = 0;
count = 0;

%Compara a imagem original com a imagem "rabiscada" e armazena os pixels de
%cada "rabisco" em um vetor
for i=1:N
    for j=1:M
        if img(i,j) ~= scb(i,j);
          count = count + 1;
          vetor(count) = img(i,j);
          mat(i,j) = img(i,j);
        end
    end
end

%Adequa o vetor com os pixels de uma região de interesse para o cálculo da FDP
%pd = fitdist(vetor','Normal');
% Calcula a FDP dos pixels de uma região de interesse
%y = pdf(pd,1:1:256);
%plot(1:1:256,y,'LineWidth',2);
end

