function [ img_scribbled, mat_img, pixels_values, y ] = getPixelsValues( imagem, regioes)
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
[~, q] = size(regioes); % Guarda o n�mero de regi�es de interesse
%Verifica se a imagem est� em RGB e se estiver converte para escala de
%cinza
if size(img,3) == 3
    img = rgb2gray(img);
else 
    % Se estiver em esccala da cinza n�o faz nada
end
[N,M] = size(img);

% Matriz que vai armazenar a informa��o espacial dos scribbles para
mat_img(N,M,q) = 0;
% Array que armazena temporariamente as imagens "rabiscadas"
img_scribbled_temp = cell(1,q);
% Matriz que armazena as imagens "rabiscadas" para compara��o com a imagem
% original
img_scribbled(N,M,q) = 0;
%scb = imread(imagem_scribbled);

% Armazena aas imagens "rabiscadas" em um vetor c�lula
for k=1:q
    img_scribbled_temp{k} = imread(regioes{k});
    % Converte a imagem para escala de cinza para facilitar a transforma��o
    % de array em matriz (para que a imagem n�o fique tri-dimensional)
    img_scribbled_temp{k} = rgb2gray(img_scribbled_temp{k});
end

% Armazena as imagens na matriz definitiva
for k=1:q
    img_scribbled(:,:,k) = img_scribbled_temp{k};
end
 
% Matriz que armazena o valor dos pixels "rabiscados". Cada linha da matriz
% representa uma regi�o da imagem a ser segmenada.
pixels_values = 0;

%Compara a imagem original com a imagem "rabiscada" e armazena os pixels de
%cada "rabisco" em um vetor, bem como guarda a posi��o dos pixels
for k=1:q
    count = 0;
    for i=1:N
        for j=1:M
            if img(i,j) ~= img_scribbled(i,j,k);
                count = count + 1;
                pixels_values(k,count) = img_scribbled(i,j,k);
                mat_img(i,j,k) = img_scribbled(i,j,k);
            end
        end
    end
end

% ----- C�lculo da FDP sem usar a fun��o "fitdist" -----
%{
[~, s] = size(vetor);
p_temp(nargin-1,256) = 0; % vetor que armazena os valores da densidade de probabilidade
%p_temp_norm(nargin-1,256) = 0; % vetor que armazena os valores normalizados da densidade de probabilidade
p(nargin-1,256) = 0; % vetor que armazena os valores da distribui��o gaussiana
%str1(nargin-1,9) = 0;
for i=1:nargin-1
    media = mean(vetor(i,:)); % Calcula a m�dia dos pixels de um rabisco
    desvio = (sqrt(var(vetor(i,:)))); % Calcula o desvio padr�o dos pixels de um rabisco
    p_temp(i,:) = 0:1:255;
    p(i,:) = pdf('Normal',p_temp(i,:),media,desvio);
    str1(i,:) = sprintf('p_{%d}^{i}', i);    
end
plot(0:1:255,p,'LineWidth',2);legend(str1);title('C�lculo da FDP sem o uso da fun��o "fitdist"');
figure;
%}

% ----- C�lculo da FDP usando a fun��o "fitdist" -----
%Adequa o vetor com os pixels de uma regi�o de interesse para o c�lculo da FDP
pixels_values = pixels_values';
x_values = 0:1:255;
%str(nargin-1,9) = 0;
y(nargin-1,256) = 0;   
for k=1:nargin-1
    pd = fitdist(pixels_values(:,k),'Normal');
    % Calcula a FDP dos pixels de uma regi�o de interesse
    y(k,:) = pdf(pd,x_values);
    str(k,:) = sprintf('p_{%d}^{i}', k);
end
%plot(x_values,y,'LineWidth',2);legend(str);title('C�lculo da FDP com o uso da fun��o "fitdist"');
end

