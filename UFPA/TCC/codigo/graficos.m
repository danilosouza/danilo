clear;

imagens = {'1';'2';'3';'4';'5';'6'};
taxas = {'100';'50';'10';'1'};
prefixo = 'Imagem';
sufixo = '_tx';
nomes = cell(4,6);

% Preenche a célula "nomes" com os nomes corretos dos arquivos .mat que
% guardam os workspaces das imagens processadas
for i=1:6
    nomes(:,i) = strcat(sufixo,taxas);
    nomes(:,i) = strcat(prefixo,imagens(i),nomes(:,i));
end

obj = cell(4,6);
% Preenche a célula "obj" com os workspaces propriamente ditos referentes
% às imagens processadas com as diferentes taxas de reamostragem
for i=1:4
    for k=1:6
        obj{i,k} = matfile(nomes{i,k});
    end
end


% Calcula a quantidade total de pixels marcados de cada imagem de saída
pixels(4,6) = 0;

for i=1:4
    for j=1:6
        pixels(i,j) = sum(sum(obj{i,j}.qtde_pixels));
    end
end

% Calcula o tempo total de execução para cada imagem e calcula
% separadamente o tempo de execução apenas dos cálculos da distância dos
% pixels
tempo(4,6,8) = 0;
tempo_distancia(4,6) = 0;

for k=1:8
    for i=1:4
        for j=1:6
            tempo(i,j,k) = obj{i,j}.tempo(1,k)/60;
            tempo_distancia(i,j) = obj{i,j}.tempo(:,7)/60;
        end
    end
end


% Calcula a quantidade total de pixels total de cada imagem de saída
tamanho(3,6) = 0;

for j=1:6
    [tamanho(1,j), tamanho(2,j), ~] = size(obj{i,j}.I);
    tamanho(3,j) = tamanho(1,j)*tamanho(2,j);
end



% Variável que guarda o tempo total de execução do algoritmo para cada
% imagem
tempo_total = sum(tempo,3);

% Variável que guarda em uma matriz quanto (em %) que o tempo do cálculo da
% distância representa em relação ao tempo total de execução do algoritmo
percent = tempo_distancia./tempo_total*100;

% Variável que guarda o tempo das reamostragens de 1, 10 e 50 % relativos
% ao tempo total de 100%
tempo_relativo = 100-(vertcat((tempo_total(2,:)./tempo_total(1,:))*100,(tempo_total(3,:)./tempo_total(1,:))*100,(tempo_total(4,:)./tempo_total(1,:))*100));


%bar(+(percent' >= 96 & percent' <= 97 ),'DisplayName','tempo_distancia');legend('Full Set','Reamostragem à 50%','Reamostragem à 10%','Reamostragem à 1%','FontSize',14);xlabel('Imagem');title('imagens com percent no intervalo [96,97]')
%figure;
%bar(+(percent' > 97 & percent' <= 98 ),'DisplayName','tempo_distancia');legend('Full Set','Reamostragem à 50%','Reamostragem à 10%','Reamostragem à 1%','FontSize',14);xlabel('Imagem');title('imagens com percent no intervalo ]97,98]')
%figure;
%bar(+(percent' > 98 & percent' <= 99 ),'DisplayName','tempo_distancia');legend('Full Set','Reamostragem à 50%','Reamostragem à 10%','Reamostragem à 1%','FontSize',14);xlabel('Imagem');title('imagens com percent no intervalo ]98,99]')
%figure;
%bar(+(percent' > 99 & percent' <= 100 ),'DisplayName','tempo_distancia');legend('Full Set','Reamostragem à 50%','Reamostragem à 10%','Reamostragem à 1%','FontSize',14);xlabel('Imagem');title('imagens com percent no intervalo ]99,100]')


% Variável que armazena o fundo das imagens em uma célula
fundo_imagens = cell(4,6);
for i=1:4
    for j=1:6
        [~,~,~,s,~] = size(obj{i,j}.resultado);
        temp = 0;
        for k=1:s
            temp = temp + obj{i,j}.resultado(:,:,:,k,1);
        end
        fundo_imagens{i,j} = temp;
    end
    
end

% Variável que armazena o erro das imagens reamostradas 
erro = cell(3,6);
erro_numerico(3,6) = 0;
erro_numerico_relativo(3,6) = 0;
for  i=1:3
    for j=1:6
        erro{i,j} = (im2double(obj{1,j}.I)-im2double(fundo_imagens{1,j}))-(im2double(obj{i+1,j}.I)-im2double(fundo_imagens{i+1,j}));
        erro_numerico(i,j) = size(find(erro{i,j}),1)/3;
    end
    erro_numerico_relativo(i,:) = 100*erro_numerico(i,:)./tamanho(3,:);
end


