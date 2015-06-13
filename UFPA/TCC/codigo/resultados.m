% Script pra gerar respostas
resposta = cell(1,4);

disp('Paisagem 1')
tic
[ ~, ~, ~, ~, resposta{1}] = segmenta( './imagens/paisagem1.png', './imagens/paisagem1_scribbled1.png', './imagens/paisagem1_scribbled2.png');
time(1,1) = toc;
disp('Paisagem 3')
tic
[ ~,  ~, ~, ~, resposta{2}] = segmenta( './imagens/paisagem3.png', './imagens/paisagem3_scribbled1.png', './imagens/paisagem3_scribbled2.png');
time(1,2) = toc;
disp('Paisagem 5')
tic
[ ~, ~, ~, ~, resposta{3}] = segmenta( './imagens/paisagem5.png', './imagens/paisagem5_scribbled1.png', './imagens/paisagem5_scribbled2.png');
time(1,3) = toc;
disp('Paisagem 8')
tic
[ ~, ~, ~, ~, resposta{4}] = segmenta( './imagens/paisagem8.png', './imagens/paisagem8_scribbled1.png', './imagens/paisagem8_scribbled2.png');
time(1,4) = toc;