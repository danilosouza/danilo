function [ y ] = getPixelsDist( arrayPosicao, imagem, n_sub_labels )
%getPixelsDist Fun��o para retornar a FDP dos pixels
%   Essa fun��o � similar a fun��o "getPixelsValues", por�m recebe como
% entrada o canal que se deseja calcular as FDP's e um array 3-D que guarda
% a posi��o dos pixels marcados para cada regi�o de interesse.

[N,M,~,q] = size(arrayPosicao);
%pixelsValues(t,count) = 0;


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
                if arrayPosicao(i,j,h,g) ~= 0
                    count = count + 1;
                    pixels_values(h,count,g) = imagem(i,j);
                else
                    
                end
            end
        end
    end
end

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


%{
for k=1:n_sub_labels
    count = 0;
    for i=1:N
        for j=1:M
            if arrayPosicao(i,j,k) ~= 0
            count = count + 1;
            pixelsValues(k,count) = imagem(i,j); 
            end
        end
    end
end
% ----- C�lculo da FDP usando a fun��o "fitdist" -----
%Adequa o vetor com os pixels de uma regi�o de interesse para o c�lculo da FDP
pixelsValues = pixelsValues';
x_values = 0:1:255;
%str(t,9) = 0;
%y(t,256) = 0;   
for k=1:n_sub_labels
    pd = fitdist(pixelsValues(:,k),'Normal');
    % Calcula a FDP dos pixels de uma regi�o de interesse
    y(k,:) = pdf(pd,x_values);
    str(k,:) = sprintf('p_{%d}^{i}', k);
end
%}



end

