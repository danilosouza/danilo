function [ img_scribbled, mat_posicao_final, pixels_values, y, img, n_sub_labels ] = getPixelsPosition(cor, imagem, regioes)
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
% Quando a imagem passada como par�metro n�o for mais um caminho, mas sim
% uma matriz de uma das componentes RGB da imagem
%img = imagem;
[~, q] = size(regioes); % Guarda o n�mero de regi�es de interesse
%Verifica se a imagem est� em RGB e se estiver converte para escala de
%cinza

if cor == 'cinza'
    img = rgb2gray(img);
    elseif cor == 'R'
        img = img(:,:,1);
        elseif cor == 'G'
            img = img(:,:,2);
            elseif cor == 'B'
                img = img(:,:,3);
end

%if size(img,3) == 3
%    img = rgb2gray(img);
%else 
    % Se estiver em esccala da cinza n�o faz nada
%end
[N,M] = size(img);

% Matriz que vai armazenar a informa��o espacial dos scribbles
mat_posicao(N,M,q) = 0;
% Array que armazena temporariamente as imagens "rabiscadas"
img_scribbled_temp = cell(1,q);
% Matriz que armazena as imagens "rabiscadas" para compara��o com a imagem
% original
img_scribbled(N,M,q) = 0;
%scb = imread(imagem_scribbled);

% Armazena aas imagens "rabiscadas" em um vetor c�lula


if cor == 'cinza'
    for k=1:q
        img_scribbled_temp{k} = rgb2gray(imread(regioes{k}));
    end
    elseif cor == 'R'
        for k=1:q
            img_scribbled_temp{k} = imread(regioes{k});
            % Pega a componente da imagem desejada (R,G ou B)
            img_scribbled_temp{k} = img_scribbled_temp{k}(:,:,1);
        end
        elseif cor == 'G'
            for k=1:q
                img_scribbled_temp{k} = imread(regioes{k});
                % Pega a componente da imagem desejada (R,G ou B)
                img_scribbled_temp{k} = img_scribbled_temp{k}(:,:,2);
            end
            elseif cor == 'B'
                for k=1:q
                    img_scribbled_temp{k} = imread(regioes{k});
                    % Pega a componente da imagem desejada (R,G ou )
                    img_scribbled_temp{k} = img_scribbled_temp{k}(:,:,3);
                end
end


% Armazena as imagens "rabiscadas" na matriz definitiva
for k=1:q
    img_scribbled(:,:,k) = img_scribbled_temp{k};
end
 
% Matriz que armazena o valor dos pixels "rabiscados". Cada linha da matriz
% representa uma regi�o da imagem a ser segmenada.
pixels_values = 0;

%Compara a imagem original com a imagem "rabiscada" e armazena os pixels de
%cada "rabisco" em um vetor, bem como guarda a posi��o dos pixels
for k=1:q
    %count = 0;
    for i=1:N
        for j=1:M
            if img(i,j) ~= img_scribbled(i,j,k);
                %count = count + 1;
                %pixels_values(k,count) = img_scribbled(i,j,k);
                mat_posicao(i,j,k) = img_scribbled(i,j,k);
            end
        end
    end
end


% Matriz que vai armazenar a informa��o espacial dos scribbles considerando
% os sub-labels
n_sub_labels(1,q) = 0;
for k=1:q
    % Recupera quantos sub-labels existem em cada label
    s = bwlabel(mat_posicao(:,:,k),8);
    % Armazena o n�mero de sub-labels por regi�o
    n_sub_labels(1,k) = max(max(s));
    for f=1:n_sub_labels(1,k)
        mat_posicao_sub_labels(:,:,f,k) = (s==f);
    end
end

% Recupera os valores dos pixels das "sub-labels" para regi�es com mais de
% uma subregi�o
for g=1:q  
    for h=1:n_sub_labels(1,g)
        % Se a regi�o n�o possuir subregi�es ent�o a matriz � atribuida de
        % forma direta, sem a necessiade de percorrer pixel a pixel as
        % matrizes de subregi�es
%        if n_sub_labels(1,g) ==1
%            mat_posicao_final(:,:,h,g) = mat_posicao(:,:,g);
%        else
        count = 0;
        for i=1:N
            for j=1:M
                % Veririfica se o pixel faz parte da subregi�o atual
                if mat_posicao_sub_labels(i,j,h,g) ~= 0
                    count = count + 1;
                    pixels_values(h,count,g) = mat_posicao(i,j,g);
                    mat_posicao_final(i,j,h,g) = mat_posicao(i,j,g);
                else
                     mat_posicao_final(i,j,h,g) = 0;
                end
            end
        end
    end
end

        
% ----- C�lculo da FDP usando a fun��o "fitdist" -----
%Adequa o vetor com os pixels de uma regi�o de interesse para o c�lculo da
%FDP, trocando linhas por colunas, mas mantendo a teceira dimens�o como
%sendo a regi�o de interesse
pixels_values = permute(pixels_values,[2 1 3]);
x_values = 0:1:255;
%str(nargin-1,9) = 0;
%y(nargin-1,256) = 0;   

for k=1:q
    for h=1:n_sub_labels(1,k)
        pd = fitdist(pixels_values(:,h,k),'Normal');
        % Calcula a FDP dos pixels de uma regi�o de interesse
        y(h,:,k) = pdf(pd,x_values);
        %str(k,:) = sprintf('p_{%d}^{i}', k);
    end
end
%plot(x_values,y,'LineWidth',2);legend(str);title('C�lculo da FDP com o uso da fun��o "fitdist"');
end

