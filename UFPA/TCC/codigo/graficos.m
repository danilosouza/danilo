clear;

imagens = {'1';'2';'3';'4';'5';'6'};
taxas = {'100';'50';'10';'1'};
prefixo = 'Imagem';
sufixo = '_tx';
nomes = cell(4,6);

% Preenche a c�lula "nomes" com os nomes corretos dos arquivos .mat que
% guardam os workspaces das imagens processadas
for i=1:6
    nomes(:,i) = strcat(sufixo,taxas);
    nomes(:,i) = strcat(prefixo,imagens(i),nomes(:,i));
end

obj = cell(4,6);
% Preenche a c�lula "obj" com os workspaces propriamente ditos referentes
% �s imagens processadas com as diferentes taxas de reamostragem
for i=1:4
    for k=1:6
        obj{i,k} = matfile(nomes{i,k});
    end
end


% Calcula a quantidade total de pixels marcados de cada imagem de sa�da
pixels(4,6) = 0;

for i=1:4
    for j=1:6
        pixels(i,j) = sum(sum(obj{i,j}.qtde_pixels));
    end
end

% Calcula o tempo total de execu��o para cada imagem e calcula
% separadamente o tempo de execu��o apenas dos c�lculos da dist�ncia dos
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


% Calcula a quantidade total de pixels total de cada imagem de sa�da
tamanho(3,6) = 0;

for j=1:6
    [tamanho(1,j), tamanho(2,j), ~] = size(obj{i,j}.I);
    tamanho(3,j) = tamanho(1,j)*tamanho(2,j);
end



% Vari�vel que guarda o tempo total de execu��o do algoritmo para cada
% imagem
tempo_total = sum(tempo,3);

% Vari�vel que guarda em uma matriz quanto (em %) que o tempo do c�lculo da
% dist�ncia representa em rela��o ao tempo total de execu��o do algoritmo
percent = tempo_distancia./tempo_total*100;

%bar(+(percent' >= 96 & percent' <= 97 ),'DisplayName','tempo_distancia');legend('Full Set','Reamostragem � 50%','Reamostragem � 10%','Reamostragem � 1%','FontSize',14);xlabel('Imagem');title('imagens com percent no intervalo [96,97]')
%figure;
%bar(+(percent' > 97 & percent' <= 98 ),'DisplayName','tempo_distancia');legend('Full Set','Reamostragem � 50%','Reamostragem � 10%','Reamostragem � 1%','FontSize',14);xlabel('Imagem');title('imagens com percent no intervalo ]97,98]')
%figure;
%bar(+(percent' > 98 & percent' <= 99 ),'DisplayName','tempo_distancia');legend('Full Set','Reamostragem � 50%','Reamostragem � 10%','Reamostragem � 1%','FontSize',14);xlabel('Imagem');title('imagens com percent no intervalo ]98,99]')
%figure;
%bar(+(percent' > 99 & percent' <= 100 ),'DisplayName','tempo_distancia');legend('Full Set','Reamostragem � 50%','Reamostragem � 10%','Reamostragem � 1%','FontSize',14);xlabel('Imagem');title('imagens com percent no intervalo ]99,100]')

