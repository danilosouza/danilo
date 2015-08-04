% Script pra gerar respostas

% ########## Imagem 6 ##########

disp('Imagem 6 a 50%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.5,'cinza', './imagens/imagem6.png', './imagens/imagem6_scribbled1.png', './imagens/imagem6_scribbled2.png');
time = etime(clock,before);
save('imagem6_tx50')

disp('Imagem 6 a 10%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.1,'cinza', './imagens/imagem6.png', './imagens/imagem6_scribbled1.png', './imagens/imagem6_scribbled2.png');
time = etime(clock,before);
save('imagem6_tx10')

disp('Imagem 6 a 1%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.01,'cinza', './imagens/imagem6.png', './imagens/imagem6_scribbled1.png', './imagens/imagem6_scribbled2.png');
time = etime(clock,before);
save('imagem6_tx1')


% ########## Imagem 10 ##########

disp('Imagem 10 a 50%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.5,'cinza', './imagens/imagem10.png', './imagens/imagem10_scribbled1.png', './imagens/imagem10_scribbled2.png');
time = etime(clock,before);
save('imagem10_tx50')

disp('Imagem 10 a 10%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.1,'cinza', './imagens/imagem10.png', './imagens/imagem10_scribbled1.png', './imagens/imagem10_scribbled2.png');
time = etime(clock,before);
save('imagem10_tx10')

disp('Imagem 10 a 1%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.01,'cinza', './imagens/imagem10.png', './imagens/imagem10_scribbled1.png', './imagens/imagem10_scribbled2.png');
time = etime(clock,before);
save('imagem10_tx1')


% ########## Imagem 12 ##########

disp('Imagem 12 a 50%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.5,'cinza', './imagens/imagem12.png', './imagens/imagem12_scribbled1.png', './imagens/imagem12_scribbled2.png');
time = etime(clock,before);
save('imagem12_tx50')

disp('Imagem 12 a 10%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.1,'cinza', './imagens/imagem12.png', './imagens/imagem12_scribbled1.png', './imagens/imagem12_scribbled2.png');
time = etime(clock,before);
save('imagem12_tx10')

disp('Imagem 12 a 1%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.01,'cinza', './imagens/imagem12.png', './imagens/imagem12_scribbled1.png', './imagens/imagem12_scribbled2.png');
time = etime(clock,before);
save('imagem12_tx1')


% ########## Imagem 13 ##########

disp('Imagem 13 a 100%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(1,'cinza', './imagens/imagem13.png', './imagens/imagem13_scribbled1.png', './imagens/imagem13_scribbled2.png');
time = etime(clock,before);
save('imagem13_tx100')

disp('Imagem 13 a 50%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.5,'cinza', './imagens/imagem13.png', './imagens/imagem13_scribbled1.png', './imagens/imagem13_scribbled2.png');
time = etime(clock,before);
save('imagem13_tx50')

disp('Imagem 13 a 10%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.1,'cinza', './imagens/imagem13.png', './imagens/imagem13_scribbled1.png', './imagens/imagem13_scribbled2.png');
time = etime(clock,before);
save('imagem13_tx10')

disp('Imagem 13 a 1%')
clear
before = clock
[ fdp, I, posicao, posicao_nova, resultado, qtde_pixels, tempo] = segmenta(0.01,'cinza', './imagens/imagem13.png', './imagens/imagem13_scribbled1.png', './imagens/imagem13_scribbled2.png');
time = etime(clock,before);
save('imagem13_tx1')

