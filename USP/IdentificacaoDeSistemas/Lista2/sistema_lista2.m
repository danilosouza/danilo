% --------------- Sistema ---------------
%clear; clc;
T = 1; % tempo de amostragem
H = tf(2,[10 1],'InputDelay',3);
Hd = c2d(H,T);
G_pert_2 = tf(2, [50 15 1]);
G_pert_2_discreta = c2d(G_pert_2,T);
G_pert_1 = tf(1, [5 1]);
G_pert_1_discreta = c2d(G_pert_1,T);
na = 1; nb = 1; nc = 1; nd = 1; nf = 1; nk = 4; %ordens do polinômios
ts = 46;
Tsim = 100;
t = 0:Tsim;

sim('lista2');
% ----------- item d ---------------
% sim('lista2_item_d')
% t = 0:600;
% plot(t,y,'k'); grid minor; legend('Saída limpa');xlabel('Tempos (s)');ylabel('Amplitude')
% figure;
% plot(t,y2,'k'); grid minor;legend('Saída com perturbação');xlabel('Tempos (s)');ylabel('Amplitude')
% ----------- item e ---------------

%sim('lista2_item_e');
y_sem_pert = iddata(y_limpa,u_entrada,T);
y_medido_pert = iddata(y2,u_entrada,T);
%z_d = iddata(y_discreto,u_entrada,T);
mdlarx = arx(y_sem_pert,[na nb nk]);
mdlarmax = armax(y_sem_pert,[na nb 0 nk]);
mdloe = oe(y_sem_pert,[nb nf nk]);
mdlbj = bj(y_sem_pert,[nb 0 0 nf nk]);
mdlfir = impulseest(y_sem_pert,ts,nk);

% opt = stepDataOptions('StepAmplitude',0.1);
% step(Hd,mdlarx,mdlarmax,mdloe,mdlbj,mdlfir,'k--',Tsim,opt);grid minor;
% legend('Processo discretizado', 'Modelo ARX', 'Modelo ARMAX', 'Modelo OE', 'Modelo BJ','Modelo FIR');
% figure;

p_arx = predict(y_sem_pert,mdlarx,Inf);
p_armax = predict(y_sem_pert,mdlarmax,Inf);
p_oe = predict(y_sem_pert,mdloe,Inf);
p_bj = predict(y_sem_pert,mdlbj,Inf);
p_fir = predict(y_sem_pert,mdlfir,Inf);
% stairs(t,y_limpa,'k');hold;
% stairs(t,p_arx.OutputData,'k:');
% stairs(t,p_armax.OutputData,'k.');
% stairs(t,p_oe.OutputData,'k-.');
% stairs(t,p_bj.OutputData,'k-');
% stairs(t,p_fir.OutputData,'k--');grid minor;xlabel('Tempo (s)');ylabel('Amplitude');title('Predição com infinitos passo à frente')
% legend('Saída y limpa','Predição do modelo ARX','Predição do modelo ARMAX','Predição do modelo OE','Predição do modelo BJ','Predição do modelo FIR');
% figure;

% [c, fit] = compare(y_sem_pert,p_arx,p_armax,p_oe,p_bj,p_fir,Inf);
% str_arx = sprintf('Modelo ARX: %.2f%%',fit{1});
% str_armax = sprintf('Modelo ARMAX: %.2f%%',fit{2});
% str_oe = sprintf('Modelo OE: %.2f%%',fit{3});
% str_bj = sprintf('Modelo BJ: %.2f%%',fit{4});
% str_fir = sprintf('Modelo FIR: %.2f%%',fit{5});
% plot(t,y_sem_pert.OutputData,'k',t,c{1}.OutputData,t,c{2}.OutputData,t,c{3}.OutputData,t,c{4}.OutputData,t,c{5}.OutputData,'g');
% legend('Saída limpa',str_arx,str_armax,str_oe,str_bj,str_fir); grid minor;
% title('Comparação com a saída limpa');xlabel('Tempo (s)');ylabel('Amplitude');
% figure;

% [c_pert, fit_pert] = compare(y_medido_pert,mdlarx,mdlarmax,mdloe,mdlbj,mdlfir,Inf);
% str_arx = sprintf('Modelo ARX: %.2f%%',fit_pert{1});
% str_armax = sprintf('Modelo ARMAX: %.2f%%',fit_pert{2});
% str_oe = sprintf('Modelo OE: %.2f%%',fit_pert{3});
% str_bj = sprintf('Modelo BJ: %.2f%%',fit_pert{4});
% str_fir = sprintf('Modelo FIR: %.2f%%',fit_pert{5});
% plot(t,y_medido_pert.OutputData,'k',t,c_pert{1}.OutputData,t,c_pert{2}.OutputData,t,c_pert{3}.OutputData,t,c_pert{4}.OutputData,t,c_pert{5}.OutputData,'g');
% legend('Saída com perturbação',str_arx,str_armax,str_oe,str_bj,str_fir); grid minor;
% title('Comparação com a saída afetada por v_{1} e v_{2}');xlabel('Tempo (s)');ylabel('Amplitude')
% figure;
% ----------- item g ---------------
% sim('C:\Users\Danilo\Documents\GitHub\danilo\USP\IdentificacaoDeSistemas\Lista1\lista1_questao7')
% stairs(0:ts,y_pulso(1:47)); hold; stairs(0:ts,[0 0 0 mdlfir.num(1:length(mdlfir.num)-3)]); grid minor;
% xlabel('Tempo (s)');ylabel('Amplitude');
% legend('Resposta ao impulso sem perturbação','Modelo FIR');

% ----------- item h ---------------
mdlarx_pert = arx(y_medido_pert,[na nb nk]);
mdlarmax_pert = armax(y_medido_pert,[na nb nc nk]);
mdloe_pert = oe(y_medido_pert,[nb nf nk]);
mdlbj_pert = bj(y_medido_pert,[nb nc nd nf nk]);
mdlfir_pert = impulseest(y_medido_pert,ts,nk);
opt = stepDataOptions('StepAmplitude',0.1);
%step(H,'k',mdlarx_pert,'k:',mdlarmax_pert,'k-.',mdloe_pert,'k-',mdlbj_pert,'k',mdlfir_pert,'k--',Tsim,opt);grid minor;

% Prefição dos modelos obtidos com perturbação
p_arx_pert = predict(y_medido_pert,mdlarx_pert,Inf);
p_armax_pert = predict(y_medido_pert,mdlarmax_pert,Inf);
p_oe_pert = predict(y_medido_pert,mdloe_pert,Inf);
p_bj_pert = predict(y_medido_pert,mdlbj_pert,Inf);
p_fir_pert = predict(y_medido_pert,mdlfir_pert,Inf);

% REsposta do sistema ao degrau (sem perturbação)
step_h = step(H,Tsim,opt);

% Obtenção da resposta ao degrau para os modelos obtidos com perturbação e
% sem perturbação
[step_mdlarx] = step(mdlarx,Tsim,opt);
[step_mdlarx_pert] = step(mdlarx_pert,Tsim,opt);
[step_mdlarmax] = step(mdlarmax,Tsim,opt);
[step_mdlarmax_pert] = step(mdlarmax_pert,Tsim,opt);
[step_mdloe] = step(mdloe,Tsim,opt);
[step_mdloe_pert] = step(mdloe_pert,Tsim,opt);
[step_mdlbj] = step(mdlbj,Tsim,opt);
[step_mdlbj_pert] = step(mdlbj_pert,Tsim,opt);
[step_mdlfir] = step(mdlfir,Tsim,opt);
[step_mdlfir_pert] = step(mdlfir_pert,Tsim,opt);

[val_h,I_h] = max(step_h);

[val_arx,I_arx] = max(step_mdlarx);
[val_arx_pert,I_arx_pert] = max(step_mdlarx_pert);

[val_armax,I_armax] = max(step_mdlarmax);
[val_armax_pert,I_armax_pert] = max(step_mdlarmax_pert);

[val_oe,I_oe] = max(step_mdloe);
[val_oe_pert,I_oe_pert] = max(step_mdloe_pert);

[val_bj,I_bj] = max(step_mdlbj);
[val_bj_pert,I_bj_pert] = max(step_mdlbj_pert);

[val_fir,I_fir] = max(step_mdlfir);
[val_fir_pert,I_fir_pert] = max(step_mdlfir_pert);

% Obtenção do ganho estacionário e seu respectivo tempo de ocorrência para
% a resposta ao degrau dos modelos obtidos com perturbação
str_h  = sprintf('Resposta limpa (K = %.4f)', val_h/opt.StepAmplitude);
% str_arx  = sprintf('Modelo ARX (K = %.4f)', val_arx_pert/opt.StepAmplitude);
% str_armax  = sprintf('Modelo ARMAX (K = %.4f)', val_armax_pert/opt.StepAmplitude);
% str_oe  = sprintf('Model  o OE (K = %.4f)', val_oe_pert/opt.StepAmplitude);
% str_bj  = sprintf('Modelo BJ (K = %.4f)', val_bj_pert/opt.StepAmplitude);
% str_fir  = sprintf('Modelo FIR (K = %.4f)', val_fir_pert/opt.StepAmplitude);
% plot(t,step_h(1:Tsim+1),'k',t,step_mdlarx_pert,'k.-',t,step_mdlarmax_pert,'k-.',t,step_mdloe_pert,'k:',t,step_mdlbj_pert,'k--',t,step_mdlfir_pert,'k.');
% grid minor;xlabel('Tempo (s)');ylabel('Amplitude');
% legend(str_h,str_arx, str_armax, str_oe, str_bj,str_fir);
% title('Modelos com perturbação');
% figure;

% [val,I] = max(step_mdlarx);
% subplot(3,2,1);plot(t,step_mdlarx,'k',t,step_mdlarx_pert,'k-.');grid minor; xlabel('Tempo (s)');ylabel('Amplitude');
% legend('Modelo ARX sem perturbação','Modelo ARX com perturbação');
% text(I,val,sprintf('\n K = %.4f', val/opt.StepAmplitude));
% text(I_arx_pert,val_arx_pert,sprintf('\n K = %.4f', val_arx_pert/opt.StepAmplitude))
% 
% [val,I] = max(step_mdlarmax);
% subplot(3,2,2);plot(t,step_mdlarmax,'k',t,step_mdlarmax_pert,'k-.');grid minor; xlabel('Tempo (s)');ylabel('Amplitude');
% legend('Modelo ARMAX sem perturbação','Modelo ARMAX com perturbação')
% text(I,val,sprintf('\n K = %.4f', val/opt.StepAmplitude));
% text(I_armax_pert,val_armax_pert,sprintf('\n K = %.4f', val_armax_pert/opt.StepAmplitude))
% 
% [val,I] = max(step_mdloe);
% subplot(3,2,3);plot(t,step_mdloe,'k',t,step_mdloe_pert,'k-.');grid minor; xlabel('Tempo (s)');ylabel('Amplitude');
% legend('Modelo OE sem perturbação','Modelo OE com perturbação')
% text(I,val,sprintf('\n K = %.4f', val/opt.StepAmplitude));
% text(I_oe_pert,val_oe_pert,sprintf('\n K = %.4f', val_oe_pert/opt.StepAmplitude))
% 
% [val,I] = max(step_mdlbj);
% subplot(3,2,4);plot(t,step_mdlbj,'k',t,step_mdlbj_pert,'k-.');grid minor; xlabel('Tempo (s)');ylabel('Amplitude');
% legend('Modelo BJ sem perturbação','Modelo BJ com perturbação')
% text(I,val,sprintf('\n K = %.4f', val/opt.StepAmplitude));
% text(I_bj_pert,val_bj_pert,sprintf('\n K = %.4f', val_bj_pert/opt.StepAmplitude))
% 
% [val,I] = max(step_mdlfir);
% subplot(3,2,5);plot(t,step_mdlfir,'k',t,step_mdlfir_pert,'k-.');grid minor; xlabel('Tempo (s)');ylabel('Amplitude');
% legend('Modelo FIR sem perturbação','Modelo FIR com perturbação')
% text(I,val,sprintf('\n K = %.4f', val/opt.StepAmplitude));
% text(I_fir_pert,val_fir_pert,sprintf('\n K = %.4f', val_fir_pert/opt.StepAmplitude))

% [c_pert, fit_pert] = compare(y_medido_pert,p_arx_pert,p_armax_pert,p_oe_pert,p_bj_pert,p_fir_pert,Inf);
% str_arx = sprintf('Predição do Modelo ARX: %.2f%%',fit_pert{1});
% str_armax = sprintf('Predição do Modelo ARMAX: %.2f%%',fit_pert{2});
% str_oe = sprintf('Predição do Modelo OE: %.2f%%',fit_pert{3});
% str_bj = sprintf('Predição do Modelo BJ: %.2f%%',fit_pert{4});
% str_fir = sprintf('Predição do Modelo FIR: %.2f%%',fit_pert{5});
% plot(t,y_medido_pert.OutputData,'k',t,c_pert{1}.OutputData,'k--.',t,c_pert{2}.OutputData,'k-.',t,c_pert{3}.OutputData,'k--',t,c_pert{4}.OutputData,'ko',t,c_pert{5}.OutputData,'k:');
% legend('Saída com perturbação',str_arx,str_armax,str_oe,str_bj,str_fir); grid minor;
% title('Comparação com a saída afetada por v_{1} e v_{2}');xlabel('Tempo (s)');ylabel('Amplitude')

% ----------- item j ---------------
sim('lista2_item_j');
y_2_ent = iddata(y_duas_ent,u_2_entradas,T);
y_medido_2_ent = iddata(y2_duas_ent,u_2_entradas,T);

% Estimando os modelos com dados obtidos com duas entradas (e sem
% perturbação na saída)
mdlarx_2_ent = arx(y_2_ent,[na nb nk]);
mdlarmax_2_ent = armax(y_2_ent,[na nb 0 nk]);
mdloe_2_ent = oe(y_2_ent,[nb nf nk]);
mdlbj_2_ent = bj(y_2_ent,[nb 0 0 nf nk]);
mdlfir_2_ent = impulseest(y_2_ent,ts,nk);

% Obtenção da resposta ao degrau para os modelos obtidos duas entradas sem
% perturbação na saída
[step_mdlarx_2_ent] = step(mdlarx_2_ent,Tsim,opt);
[step_mdlarmax_2_ent] = step(mdlarmax_2_ent,Tsim,opt);
[step_mdloe_2_ent] = step(mdloe_2_ent,Tsim,opt);
[step_mdlbj_2_ent] = step(mdlbj_2_ent,Tsim,opt);
[step_mdlfir_2_ent] = step(mdlfir_2_ent,Tsim,opt);

% Obtendo o ganho estacionário da respsota ao degrau dos modelos sem perturbação
[val_arx_2_ent,~] = max(step_mdlarx_2_ent);
[val_armax_2_ent,~] = max(step_mdlarmax_2_ent);
[val_oe_2_ent,~] = max(step_mdloe_2_ent);
[val_bj_2_ent,~] = max(step_mdlbj_2_ent);
[val_fir_2_ent,~] = max(step_mdlfir_2_ent);

str_arx_2_ent  = sprintf('Modelo ARX (duas entradas) (K = %.4f)', val_arx_2_ent/opt.StepAmplitude);
str_armax_2_ent  = sprintf('Modelo ARMAX (duas entradas) (K = %.4f)', val_armax_2_ent/opt.StepAmplitude);
str_oe_2_ent  = sprintf('Modelo OE (duas entradas) (K = %.4f)', val_oe_2_ent/opt.StepAmplitude);
str_bj_2_ent  = sprintf('Modelo BJ (duas entradas) (K = %.4f)', val_bj_2_ent/opt.StepAmplitude);
str_fir_2_ent  = sprintf('Modelo FIR (duas entradas) (K = %.4f)', val_fir_2_ent/opt.StepAmplitude);
plot(t,step_h(1:Tsim+1),'k',t,step_mdlarx_2_ent,'k.-',t,step_mdlarmax_2_ent,'k-.',t,step_mdloe_2_ent,'k:',t,step_mdlbj_2_ent,'k--',t,step_mdlfir_2_ent,'k.');
grid minor;xlabel('Tempo (s)');ylabel('Amplitude');
title('Modelos estimados com duas entradas e sem perturbação');
legend(str_h,str_arx_2_ent, str_armax_2_ent, str_oe_2_ent, str_bj_2_ent,str_fir_2_ent);
figure;

% Estimando os modelos com dados obtidos com duas entradas (e com
% perturbação na saída)
mdlarx_2_ent_pert = arx(y_medido_2_ent,[na nb nk]);
mdlarmax_2_ent_pert = armax(y_medido_2_ent,[na nb nc nk]);
mdloe_2_ent_pert = oe(y_medido_2_ent,[nb nf nk]);
mdlbj_2_ent_pert = bj(y_medido_2_ent,[nb nc nd nf nk]);
mdlfir_2_ent_pert = impulseest(y_medido_2_ent,ts,nk);

% Obtenção da resposta ao degrau para os modelos obtidos duas entradas e
% perturbação na saída
[step_mdlarx_2_ent_pert] = step(mdlarx_2_ent_pert,Tsim,opt);
[step_mdlarmax_2_ent_pert] = step(mdlarmax_2_ent_pert,Tsim,opt);
[step_mdloe_2_ent_pert] = step(mdloe_2_ent_pert,Tsim,opt);
[step_mdlbj_2_ent_pert] = step(mdlbj_2_ent_pert,Tsim,opt);
[step_mdlfir_2_ent_pert] = step(mdlfir_2_ent_pert,Tsim,opt);

% Obtendo o ganho estacionário da respsota ao degrau dos modelos afetados
% por perturbação
[val_arx_2_ent_pert,I_arx_2_ent] = max(step_mdlarx_2_ent_pert);
[val_armax_2_ent_pert,I_armax_2_ent] = max(step_mdlarmax_2_ent_pert);
[val_oe_2_ent_pert,I_oe_2_ent] = max(step_mdloe_2_ent_pert);
[val_bj_2_ent_pert,I_bj_2_ent] = max(step_mdlbj_2_ent_pert);
[val_fir_2_ent_pert,I_fir_2_ent] = max(step_mdlfir_2_ent_pert);

str_arx_2_ent_pert = sprintf('Modelo ARX (duas entradas) (K = %.4f)', val_arx_2_ent_pert/opt.StepAmplitude);
str_armax_2_ent_pert = sprintf('Modelo ARMAX (duas entradas) (K = %.4f)', val_armax_2_ent_pert/opt.StepAmplitude);
str_oe_2_ent_pert = sprintf('Modelo OE (duas entradas) (K = %.4f)', val_oe_2_ent_pert/opt.StepAmplitude);
str_bj_2_ent_pert = sprintf('Modelo BJ (duas entradas) (K = %.4f)', val_bj_2_ent_pert/opt.StepAmplitude);
str_fir_2_ent_pert = sprintf('Modelo FIR (duas entradas) (K = %.4f)', val_fir_2_ent_pert/opt.StepAmplitude);
plot(t,step_h(1:Tsim+1),'k',t,step_mdlarx_2_ent_pert,'k.-',t,step_mdlarmax_2_ent_pert,'k-.',t,step_mdloe_2_ent_pert,'k:',t,step_mdlbj_2_ent_pert,'k--',t,step_mdlfir_2_ent_pert,'k.');
grid minor;xlabel('Tempo (s)');ylabel('Amplitude');
title('Modelos estimados com duas entradas e com perturbação');
legend(str_h,str_arx_2_ent_pert, str_armax_2_ent_pert, str_oe_2_ent_pert, str_bj_2_ent_pert,str_fir_2_ent_pert);
figure;


% #####################################################################
% Comparação entre modelos do item atual com modelos
% do item anterior 
% #####################################################################

% Comparação da saída limpa do processo com os modelos estimados com
% perturbação para 1 entrada
[c_limpa, fit_pert] = compare(y_sem_pert,mdlarx_pert,mdlarmax_pert,mdloe_pert,mdlbj_pert,mdlfir_pert,Inf);
str_arx = sprintf('ARX: %.2f%%',fit_pert{1});
str_armax = sprintf('ARMAX: %.2f%%',fit_pert{2});
str_oe = sprintf('OE: %.2f%%',fit_pert{3});
str_bj = sprintf('BJ: %.2f%%',fit_pert{4});
str_fir = sprintf('FIR: %.2f%%',fit_pert{5});
subplot(2,1,1);plot(t,y_sem_pert.OutputData,t,c_limpa{1}.OutputData,t,c_limpa{2}.OutputData,t,c_limpa{3}.OutputData,t,c_limpa{4}.OutputData,t,c_limpa{5}.OutputData,'g');
legend('Saída limpa',str_arx,str_armax,str_oe,str_bj,str_fir); grid minor;
title('Comparação dos modelos estimados com a saída sem perturbação (para uma entrada)');xlabel('Tempo (s)');ylabel('Amplitude')

% Comparação da saída limpa do processo com os modelos estimados com
% perturbação para 2 entradas
[c_limpa_2_ent, fit_pert] = compare(y_2_ent,mdlarx_2_ent_pert,mdlarmax_2_ent_pert,mdloe_2_ent_pert,mdlbj_2_ent_pert,mdlfir_2_ent_pert,Inf);
str_arx = sprintf('ARX: %.2f%%',fit_pert{1});
str_armax = sprintf('ARMAX: %.2f%%',fit_pert{2});
str_oe = sprintf('OE: %.2f%%',fit_pert{3});
str_bj = sprintf('BJ: %.2f%%',fit_pert{4});
str_fir = sprintf('FIR: %.2f%%',fit_pert{5});
subplot(2,1,2);plot(t,y_sem_pert.OutputData,t,c_limpa_2_ent{1}.OutputData,t,c_limpa_2_ent{2}.OutputData,t,c_limpa_2_ent{3}.OutputData,t,c_limpa_2_ent{4}.OutputData,t,c_limpa_2_ent{5}.OutputData,'g');
legend('Saída limpa',str_arx,str_armax,str_oe,str_bj,str_fir); grid minor;
title('Comparação dos modelos estimados com a saída sem perturbação (para duas entrada)');xlabel('Tempo (s)');ylabel('Amplitude')
figure;

% Comparação da saída com perturbação com os modelos estimados com
% perturbação para 1 entrada
[c_pert, fit_pert] = compare(y_medido_pert,mdlarx_pert,mdlarmax_pert,mdloe_pert,mdlbj_pert,mdlfir_pert,Inf);
str_arx = sprintf('ARX: %.2f%%',fit_pert{1});
str_armax = sprintf('ARMAX: %.2f%%',fit_pert{2});
str_oe = sprintf('OE: %.2f%%',fit_pert{3});
str_bj = sprintf('BJ: %.2f%%',fit_pert{4});
str_fir = sprintf('FIR: %.2f%%',fit_pert{5});
subplot(2,1,1);plot(t,y_medido_pert.OutputData,t,c_pert{1}.OutputData,t,c_pert{2}.OutputData,t,c_pert{3}.OutputData,t,c_pert{4}.OutputData,t,c_pert{5}.OutputData,'g');
legend('Saída com ruído',str_arx,str_armax,str_oe,str_bj,str_fir); grid minor;
title('Comparação dos modelos estimados com a saída afetada por v_{1} e v_{2} (para uma entrada)');xlabel('Tempo (s)');ylabel('Amplitude')


% Comparação da saída com perturbação com os modelos estimados com
% perturbação para 2 entradas
[c_pert_2_ent, fit_pert] = compare(y_medido_2_ent,mdlarx_2_ent_pert,mdlarmax_2_ent_pert,mdloe_2_ent_pert,mdlbj_2_ent_pert,mdlfir_2_ent_pert,Inf);
str_arx = sprintf('ARX: %.2f%%',fit_pert{1});
str_armax = sprintf('ARMAX: %.2f%%',fit_pert{2});
str_oe = sprintf('OE: %.2f%%',fit_pert{3});
str_bj = sprintf('BJ: %.2f%%',fit_pert{4});
str_fir = sprintf('FIR: %.2f%%',fit_pert{5});
subplot(2,1,2);plot(t,y_medido_pert.OutputData,t,c_pert_2_ent{1}.OutputData,t,c_pert_2_ent{2}.OutputData,t,c_pert_2_ent{3}.OutputData,t,c_pert_2_ent{4}.OutputData,t,c_pert_2_ent{5}.OutputData,'g');
legend('Saída com ruído',str_arx,str_armax,str_oe,str_bj,str_fir); grid minor;
title('Comparação dos modelos estimados com a saída afetada por v_{1} e v_{2} (para duas entrada)');xlabel('Tempo (s)');ylabel('Amplitude')
figure;
% ----------- item k ---------------
% Obtenção do ganho estacionário e seu respectivo tempo de ocorrência para
% a resposta ao degrau dos modelos obtidos sem perturbação

% str_h  = sprintf('Resposta limpa (K = %.4f)', val_h/opt.StepAmplitude);
% str_arx  = sprintf('Modelo ARX (K = %.4f)', val_arx/opt.StepAmplitude);
% str_armax  = sprintf('Modelo ARMAX (K = %.4f)', val_armax/opt.StepAmplitude);
% str_oe  = sprintf('Model  o OE (K = %.4f)', val_oe/opt.StepAmplitude);
% str_bj  = sprintf('Modelo BJ (K = %.4f)', val_bj/opt.StepAmplitude);
% str_fir  = sprintf('Modelo FIR (K = %.4f)', val_fir/opt.StepAmplitude);
% plot(t,step_h(1:Tsim+1),'k',t,step_mdlarx,'k.-',t,step_mdlarmax,'k-.',t,step_mdloe,'k:',t,step_mdlbj,'k--',t,step_mdlfir,'k.');
% grid minor;xlabel('Tempo (s)');ylabel('Amplitude');
% legend(str_h,str_arx, str_armax, str_oe, str_bj,str_fir);
% title('Modelos sem perturbação');
