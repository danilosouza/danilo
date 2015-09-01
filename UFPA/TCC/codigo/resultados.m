% Script pra gerar respostas



% ########## Imagem 20 ##########

disp('Imagem 20 a 1%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.01,'cinza', './imagens/imagem20.png', './imagens/imagem20_scribbled1.png', './imagens/imagem20_scribbled2.png');
time = etime(clock,before);
save('imagem20_tx1')


% ########## Imagem 21 ##########

disp('Imagem 21 a 100%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(1,'cinza', './imagens/imagem21.png', './imagens/imagem21_scribbled1.png', './imagens/imagem21_scribbled2.png');
time = etime(clock,before);
save('imagem21_tx100')

disp('Imagem 21 a 50%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.5,'cinza', './imagens/imagem21.png', './imagens/imagem21_scribbled1.png', './imagens/imagem21_scribbled2.png');
time = etime(clock,before);
save('imagem21_tx50')

disp('Imagem 21 a 10%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.1,'cinza', './imagens/imagem21.png', './imagens/imagem21_scribbled1.png', './imagens/imagem21_scribbled2.png');
time = etime(clock,before);
save('imagem21_tx10')

disp('Imagem 21 a 1%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.01,'cinza', './imagens/imagem21.png', './imagens/imagem21_scribbled1.png', './imagens/imagem21_scribbled2.png');
time = etime(clock,before);
save('imagem21_tx1')













