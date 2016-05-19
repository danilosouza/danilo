% --------------- Sistema ---------------
%clear; clc;
T = 1; % per�odo de amostragem
H = tf(2,[10 1],'InputDelay',3);
Hd = c2d(H,T);
G_pert_2 = tf(2, [50 15 1]);
G_pert_2_discreta = c2d(G_pert_2,T);
G_pert_1 = tf(1, [5 1]);
G_pert_1_discreta = c2d(G_pert_1,T);
na = 1; nb = 1; nc = 1; nd = 1; nf = 1; nk = 4; %ordens do polin�mios
ts = 46;
Tsim = 600;
t = 0:Tsim;

%sim('lista3');
sim('lista2_item_j');
% Resposta do sistema ao degrau (sem perturba��o)
opt = stepDataOptions('StepAmplitude',0.1);
step_h = step(H,Tsim,opt);
[val_h,I_h] = max(step_h);
% ----------- item a ---------------
prbs_lento = [(0:600)' prbs(601,20*T,0.1)];
prbs_rapido = [(0:600)' prbs(601,4*T,0.1)];
prbs_1001 = [(0:1000)' prbs(1001,20*T,0.1)];
prbs_1001_rapido = [(0:1000)' prbs(1001,4*T,0.1)];

% plot(prbs_lento(:,2)); grid  minor; legend('Sinal PRBS lento (T_{b} = 20T)');
% figure;
% ----------- item b ---------------
sim('lista3_item_b');

% plot(y_pert_601);grid minor; legend('Processo sem perturba��o usando PRBS como entrada')
% figure;
% 
% plot(y2_pert_601);grid minor; legend('Processo com perturba��o usando PRBS como entrada')
% figure;

% ----------- item c ---------------
% z_prbs_601 = iddata(y_prbs_601,u_prbs_601,T);
% z2_prbs_601 = iddata(y2_prbs_601,u_prbs_601,T);
% 
% % Estimando os modelos com dados obtidos com PRBS (e sem
% % perturba��o na sa�da)
% mdlarx_601 = arx(z_prbs_601,[na nb nk]);
% mdlarmax_601 = armax(z_prbs_601,[na nb 0 nk]);
% mdloe_601 = oe(z_prbs_601,[nb nf nk]);
% mdlbj_601 = bj(z_prbs_601,[nb 0 0 nf nk]);
% mdlfir_601 = impulseest(z_prbs_601,ts,nk);
% 
% % Obten��o da resposta ao degrau para os modelos obtidos duas entradas sem
% % perturba��o na sa�da
% [step_mdlarx_601] = step(mdlarx_601,Tsim,opt);
% [step_mdlarmax_601] = step(mdlarmax_601,Tsim,opt);
% [step_mdloe_601] = step(mdloe_601,Tsim,opt);
% [step_mdlbj_601] = step(mdlbj_601,Tsim,opt);
% [step_mdlfir_601] = step(mdlfir_601,Tsim,opt);
% 
% % Obtendo o ganho estacion�rio da respsota ao degrau dos modelos sem perturba��o
% [val_arx_601,~] = max(step_mdlarx_601);
% [val_armax_601,~] = max(step_mdlarmax_601);
% [val_oe_601,~] = max(step_mdloe_601);
% [val_bj_601,~] = max(step_mdlbj_601);
% [val_fir_601,~] = max(step_mdlfir_601);
% 
% % Estimando os modelos com dados obtidos com PRBS (e com
% % perturba��o na sa�da)
% mdlarx_pert_601 = arx(z2_prbs_601,[na nb nk]);
% mdlarmax_pert_601 = armax(z2_prbs_601,[na nb nc nk]);
% mdloe_pert_601 = oe(z2_prbs_601,[nb nf nk]);
% mdlbj_pert_601 = bj(z2_prbs_601,[nb nc nd nf nk]);
% mdlfir_pert_601 = impulseest(z2_prbs_601,ts,nk);
% 
% % Obten��o da resposta ao degrau para os modelos obtidos duas entradas sem
% % perturba��o na sa�da
% [step_mdlarx_pert_601] = step(mdlarx_pert_601,Tsim,opt);
% [step_mdlarmax_pert_601] = step(mdlarmax_pert_601,Tsim,opt);
% [step_mdloe_pert_601] = step(mdloe_pert_601,Tsim,opt);
% [step_mdlbj_pert_601] = step(mdlbj_pert_601,Tsim,opt);
% [step_mdlfir_pert_601] = step(mdlfir_pert_601,Tsim,opt);
% 
% % Obtendo o ganho estacion�rio da respsota ao degrau dos modelos sem perturba��o
% [val_arx_pert_601,~] = max(step_mdlarx_pert_601);
% [val_armax_pert_601,~] = max(step_mdlarmax_pert_601);
% [val_oe_pert_601,~] = max(step_mdloe_pert_601);
% [val_bj_pert_601,~] = max(step_mdlbj_pert_601);
% [val_fir_pert_601,~] = max(step_mdlfir_pert_601);
% 
% % str_arx_pert_601  = sprintf('Modelo ARX (duas entradas) (K = %.4f)', val_arx_601/opt.StepAmplitude);
% % str_armax_pert_601  = sprintf('Modelo ARMAX (duas entradas) (K = %.4f)', val_armax_601/opt.StepAmplitude);
% % str_oe_pert_601  = sprintf('Modelo OE (duas entradas) (K = %.4f)', val_oe_601/opt.StepAmplitude);
% % str_bj_pert_601  = sprintf('Modelo BJ (duas entradas) (K = %.4f)', val_bj_601/opt.StepAmplitude);
% % str_fir_pert_601  = sprintf('Modelo FIR (duas entradas) (K = %.4f)', val_fir_601/opt.StepAmplitude);
% % plot(t,step_h(1:Tsim+1),t,step_mdlarx_pert_601,t,step_mdlarmax_pert_601,t,step_mdloe_pert_601,t,step_mdlbj_pert_601,t,step_mdlfir_pert_601);
% % grid minor;xlabel('Tempo (s)');ylabel('Amplitude');
% % title('Resposta ao degrau dos modelos estimados com PRBS sem perturba��o');
% % legend(str_h,str_arx_pert_601, str_armax_pert_601, str_oe_pert_601, str_bj_pert_601,str_fir_pert_601);
% % figure;
% 
% % Compara��o da sa�da limpa do processo com os modelos estimados com
% % perturba��o 
% [c_limpa, fit_pert] = compare(z_prbs_601,mdlarx_601,mdlarmax_601,mdloe_601,mdlbj_601,mdlfir_601,Inf);
% str_arx = sprintf('ARX: %.2f%%',fit_pert{1});
% str_armax = sprintf('ARMAX: %.2f%%',fit_pert{2});
% str_oe = sprintf('OE: %.2f%%',fit_pert{3});
% str_bj = sprintf('BJ: %.2f%%',fit_pert{4});
% str_fir = sprintf('FIR: %.2f%%',fit_pert{5});
% subplot(2,1,1);plot(t,z_prbs_601.OutputData,t,c_limpa{1}.OutputData,t,c_limpa{2}.OutputData,t,c_limpa{3}.OutputData,t,c_limpa{4}.OutputData,t,c_limpa{5}.OutputData);
% legend('Sa�da limpa',str_arx,str_armax,str_oe,str_bj,str_fir); grid minor;
% title('Compara��o dos modelos estimados (com dados do processo limpo) usando PRBS para sa�da sem perturba��o');xlabel('Tempo (s)');ylabel('Amplitude')
% 
% % Compara��o da sa�da com perturba��o do processo com os modelos estimados com
% % perturba��o
% [c_pert, fit_pert] = compare(z2_prbs_601,mdlarx_pert_601,mdlarmax_pert_601,mdloe_pert_601,mdlbj_pert_601,mdlfir_pert_601,Inf);
% str_arx = sprintf('ARX: %.2f%%',fit_pert{1});
% str_armax = sprintf('ARMAX: %.2f%%',fit_pert{2});
% str_oe = sprintf('OE: %.2f%%',fit_pert{3});
% str_bj = sprintf('BJ: %.2f%%',fit_pert{4});
% str_fir = sprintf('FIR: %.2f%%',fit_pert{5});
% subplot(2,1,2);plot(t,z2_prbs_601.OutputData,t,c_pert{1}.OutputData,t,c_pert{2}.OutputData,t,c_pert{3}.OutputData,t,c_pert{4}.OutputData,t,c_pert{5}.OutputData);
% legend('Sa�da com perturba��o',str_arx,str_armax,str_oe,str_bj,str_fir); grid minor;
% title('Compara��o dos modelos estimados (com dados do processo com perturba��o) usando PRBS para a sa�da com perturba��o');xlabel('Tempo (s)');ylabel('Amplitude')
% % figure;

% ----------- item d ---------------
sim('lista3_item_d');
z_prbs_601_rapido = iddata(y_prbs_601_rapido,u_prbs_601_rapido,T);
z2_prbs_601_rapido = iddata(y2_prbs_601_rapido,u_prbs_601_rapido,T);

% % Estimando os modelos com dados obtidos com PRBS (e sem
% % perturba��o na sa�da)
% mdlarx_601_rapido = arx(z_prbs_601_rapido,[na nb nk]);
% mdlarmax_601_rapido = armax(z_prbs_601_rapido,[na nb 0 nk]);
% mdloe_601_rapido = oe(z_prbs_601_rapido,[nb nf nk]);
% mdlbj_601_rapido = bj(z_prbs_601_rapido,[nb 0 0 nf nk]);
% mdlfir_601_rapido = impulseest(z_prbs_601_rapido,ts,nk);
% 
% % Obten��o da resposta ao degrau para os modelos obtidos duas entradas sem
% % perturba��o na sa�da
% [step_mdlarx_601_rapido] = step(mdlarx_601_rapido,Tsim,opt);
% [step_mdlarmax_601_rapido] = step(mdlarmax_601_rapido,Tsim,opt);
% [step_mdloe_601_rapido] = step(mdloe_601_rapido,Tsim,opt);
% [step_mdlbj_601_rapido] = step(mdlbj_601_rapido,Tsim,opt);
% [step_mdlfir_601_rapido] = step(mdlfir_601_rapido,Tsim,opt);
% 
% % Obtendo o ganho estacion�rio da respsota ao degrau dos modelos sem perturba��o
% [val_arx_601_rapido,~] = max(step_mdlarx_601_rapido);
% [val_armax_601_rapido,~] = max(step_mdlarmax_601_rapido);
% [val_oe_601_rapido,~] = max(step_mdloe_601_rapido);
% [val_bj_601_rapido,~] = max(step_mdlbj_601_rapido);
% [val_fir_601_rapido,~] = max(step_mdlfir_601_rapido);
% 
% % Estimando os modelos com dados obtidos com PRBS (e com
% % perturba��o na sa�da)
% mdlarx_pert_601_rapido = arx(z2_prbs_601_rapido,[na nb nk]);
% mdlarmax_pert_601_rapido = armax(z2_prbs_601_rapido,[na nb nc nk]);
% mdloe_pert_601_rapido = oe(z2_prbs_601_rapido,[nb nf nk]);
% mdlbj_pert_601_rapido = bj(z2_prbs_601_rapido,[nb nc nd nf nk]);
% mdlfir_pert_601_rapido = impulseest(z2_prbs_601_rapido,ts,nk);
% 
% % Obten��o da resposta ao degrau para os modelos obtidos duas entradas sem
% % perturba��o na sa�da
% [step_mdlarx_pert_601_rapido] = step(mdlarx_pert_601_rapido,Tsim,opt);
% [step_mdlarmax_pert_601_rapido] = step(mdlarmax_pert_601_rapido,Tsim,opt);
% [step_mdloe_pert_601_rapido] = step(mdloe_pert_601_rapido,Tsim,opt);
% [step_mdlbj_pert_601_rapido] = step(mdlbj_pert_601_rapido,Tsim,opt);
% [step_mdlfir_pert_601_rapido] = step(mdlfir_pert_601_rapido,Tsim,opt);
% 
% % Obtendo o ganho estacion�rio da respsota ao degrau dos modelos sem perturba��o
% [val_arx_pert_601_rapido,~] = max(step_mdlarx_pert_601_rapido);
% [val_armax_pert_601_rapido,~] = max(step_mdlarmax_pert_601_rapido);
% [val_oe_pert_601_rapido,~] = max(step_mdloe_pert_601_rapido);
% [val_bj_pert_601_rapido,~] = max(step_mdlbj_pert_601_rapido);
% [val_fir_pert_601_rapido,~] = max(step_mdlfir_pert_601_rapido);
% 
% % str_arx_pert_601_rapido  = sprintf('Modelo ARX (duas entradas) (K = %.4f)', val_arx_601_rapido/opt.StepAmplitude);
% % str_armax_pert_601_rapido  = sprintf('Modelo ARMAX (duas entradas) (K = %.4f)', val_armax_601_rapido/opt.StepAmplitude);
% % str_oe_pert_601_rapido  = sprintf('Modelo OE (duas entradas) (K = %.4f)', val_oe_601_rapido/opt.StepAmplitude);
% % str_bj_pert_601_rapido  = sprintf('Modelo BJ (duas entradas) (K = %.4f)', val_bj_601_rapido/opt.StepAmplitude);
% % str_fir_pert_601_rapido  = sprintf('Modelo FIR (duas entradas) (K = %.4f)', val_fir_601_rapido/opt.StepAmplitude);
% % plot(t,step_h(1:Tsim+1),t,step_mdlarx_pert_601_rapido,t,step_mdlarmax_pert_601_rapido,t,step_mdloe_pert_601_rapido,t,step_mdlbj_pert_601_rapido,t,step_mdlfir_pert_601_rapido);
% % grid minor;xlabel('Tempo (s)');ylabel('Amplitude');
% % title('Resposta ao degrau dos modelos estimados com PRBS sem perturba��o');
% % legend(str_h,str_arx_pert_601_rapido, str_armax_pert_601_rapido, str_oe_pert_601_rapido, str_bj_pert_601_rapido,str_fir_pert_601_rapido);
% % figure;
% 
% % Compara��o da sa�da limpa do processo com os modelos estimados com
% % perturba��o 
% [c_limpa, fit_pert] = compare(z_prbs_601_rapido,mdlarx_601_rapido,mdlarmax_601_rapido,mdloe_601_rapido,mdlbj_601_rapido,mdlfir_601_rapido,Inf);
% str_arx = sprintf('ARX: %.2f%%',fit_pert{1});
% str_armax = sprintf('ARMAX: %.2f%%',fit_pert{2});
% str_oe = sprintf('OE: %.2f%%',fit_pert{3});
% str_bj = sprintf('BJ: %.2f%%',fit_pert{4});
% str_fir = sprintf('FIR: %.2f%%',fit_pert{5});
% subplot(2,1,1);plot(t,z_prbs_601_rapido.OutputData,t,c_limpa{1}.OutputData,t,c_limpa{2}.OutputData,t,c_limpa{3}.OutputData,t,c_limpa{4}.OutputData,t,c_limpa{5}.OutputData);
% legend('Sa�da limpa',str_arx,str_armax,str_oe,str_bj,str_fir); grid minor;
% title('Compara��o dos modelos estimados (com dados do processo limpo) usando PRBS para sa�da sem perturba��o');xlabel('Tempo (s)');ylabel('Amplitude')
% 
% % Compara��o da sa�da com perturba��o do processo com os modelos estimados com
% % perturba��o
% [c_pert, fit_pert] = compare(z2_prbs_601_rapido,mdlarx_pert_601_rapido,mdlarmax_pert_601_rapido,mdloe_pert_601_rapido,mdlbj_pert_601_rapido,mdlfir_pert_601_rapido,Inf);
% str_arx = sprintf('ARX: %.2f%%',fit_pert{1});
% str_armax = sprintf('ARMAX: %.2f%%',fit_pert{2});
% str_oe = sprintf('OE: %.2f%%',fit_pert{3});
% str_bj = sprintf('BJ: %.2f%%',fit_pert{4});
% str_fir = sprintf('FIR: %.2f%%',fit_pert{5});
% subplot(2,1,2);plot(t,z2_prbs_601_rapido.OutputData,t,c_pert{1}.OutputData,t,c_pert{2}.OutputData,t,c_pert{3}.OutputData,t,c_pert{4}.OutputData,t,c_pert{5}.OutputData);
% legend('Sa�da com perturba��o',str_arx,str_armax,str_oe,str_bj,str_fir); grid minor;
% title('Compara��o dos modelos estimados (com dados do processo com perturba��o) usando PRBS para a sa�da com perturba��o');xlabel('Tempo (s)');ylabel('Amplitude')
% % figure;

% ----------- item e ---------------
Tsim_e = 1000;
t_e = 0:Tsim_e;
sim('lista3_item_e');

%plot(t_e,y2_prbs_1001); grid minor; legend('Sa�da com perturba��o usando PRBS de 1000 pontos')

% ----------- item f ---------------

z2_prbs_1001 = iddata(y2_prbs_1001(1:601),u_prbs_1001(1:601),T);
z2_prbs_1001_valid = iddata(y2_prbs_1001(601:Tsim_e),u_prbs_1001(601:Tsim_e),T);

% Estimando os modelos com dados obtidos com PRBS (e com
% perturba��o na sa�da)
mdlarx_1001 = arx(z2_prbs_1001,[na nb nk]);
mdlarmax_1001 = armax(z2_prbs_1001,[na nb nc nk]);
mdloe_1001 = oe(z2_prbs_1001,[nb nf nk]);
mdlbj_1001 = bj(z2_prbs_1001,[nb nc nd nf nk]);
mdlfir_1001 = impulseest(z2_prbs_1001,ts,nk);

% Obten��o da resposta ao degrau para os modelos obtidos duas entradas sem
% perturba��o na sa�da
[step_mdlarx_1001] = step(mdlarx_1001,Tsim,opt);
[step_mdlarmax_1001] = step(mdlarmax_1001,Tsim,opt);
[step_mdloe_1001] = step(mdloe_1001,Tsim,opt);
[step_mdlbj_1001] = step(mdlbj_1001,Tsim,opt);
[step_mdlfir_1001] = step(mdlfir_1001,Tsim,opt);

% t = 0:600;
% plot(t,step_h(1:length(t)),t,step_mdlarx_1001,t,step_mdlarmax_1001,t,step_mdloe_1001,t,step_mdlbj_1001,t,step_mdlfir_1001);
% grid minor; legend('Sa�da limpa','Modelo ARX','Modelo ARMAX','Modelo OE','Modelo BJ','Modelo FIR')
% title('Resposta ao degrau dos modelos identificados com PRBS')
% figure;
% Obtendo o ganho estacion�rio da respsota ao degrau dos modelos sem perturba��o
[val_arx_1001,~] = max(step_mdlarx_1001);
[val_armax_1001,~] = max(step_mdlarmax_1001);
[val_oe_1001,~] = max(step_mdloe_1001);
[val_bj_1001,~] = max(step_mdlbj_1001);
[val_fir_1001,~] = max(step_mdlfir_1001);

% ----------- item g ---------------
% % Compara��o da sa�da com perturba��o do processo com os modelos estimados com
% % perturba��o 
% t = 0:399;
% [c_pert_1001, fit_pert] = compare(z2_prbs_1001_valid,mdlarx_1001,mdlarmax_1001,mdloe_1001,mdlbj_1001,mdlfir_1001);
% str_arx = sprintf('ARX: %.2f%%',fit_pert{1});
% str_armax = sprintf('ARMAX: %.2f%%',fit_pert{2});
% str_oe = sprintf('OE: %.2f%%',fit_pert{3});
% str_bj = sprintf('BJ: %.2f%%',fit_pert{4});
% str_fir = sprintf('FIR: %.2f%%',fit_pert{5});
% plot(t,z2_prbs_1001_valid.OutputData,t,c_pert_1001{1}.OutputData,t,c_pert_1001{2}.OutputData,t,c_pert_1001{3}.OutputData,t,c_pert_1001{4}.OutputData,t,c_pert_1001{5}.OutputData);
% legend('Sa�da do processo',str_arx,str_armax,str_oe,str_bj,str_fir); grid minor;
% title('Valida��o cruzada dos modelos obtidos com PRBS');xlabel('Tempo (s)');ylabel('Amplitude')
% figure;

% ----------- item h ---------------

sim('lista3_item_h');
%Tsim_h = 600;

z2_degrau_275 = iddata(y2_degrau_275,u_degrau_275,T);

% % Compara��o da sa�da com perturba��o (ao degrau) do processo com os modelos estimados com
% % perturba��o 
% t = 0:600;
% [c_pert_1001, fit_pert] = compare(z2_degrau_275,mdlarx_1001,mdlarmax_1001,mdloe_1001,mdlbj_1001,mdlfir_1001);
% str_arx = sprintf('ARX: %.2f%%',fit_pert{1});
% str_armax = sprintf('ARMAX: %.2f%%',fit_pert{2});
% str_oe = sprintf('OE: %.2f%%',fit_pert{3});
% str_bj = sprintf('BJ: %.2f%%',fit_pert{4});
% str_fir = sprintf('FIR: %.2f%%',fit_pert{5});
% plot(t,z2_degrau_275.OutputData,t,c_pert_1001{1}.OutputData,t,c_pert_1001{2}.OutputData,t,c_pert_1001{3}.OutputData,t,c_pert_1001{4}.OutputData,t,c_pert_1001{5}.OutputData);
% legend('Sa�da do processo',str_arx,str_armax,str_oe,str_bj,str_fir); grid minor;
% title('Valida��o dos modelos estimados com PRBS usando um degrau como entrada');xlabel('Tempo (s)');ylabel('Amplitude')
% figure;
% ----------- item i ---------------

% % Obten��o do ganho estacion�rio para
% % a resposta ao degrau dos modelos obtidos com perturba��o
% 
% str_h  = sprintf('Resposta limpa (K = %.4f)', val_h/opt.StepAmplitude);
% str_arx  = sprintf('Modelo ARX (K = %.4f)', val_arx_1001/opt.StepAmplitude);
% str_armax  = sprintf('Modelo ARMAX (K = %.4f)', val_armax_1001/opt.StepAmplitude);
% str_oe  = sprintf('Model  o OE (K = %.4f)', val_oe_1001/opt.StepAmplitude);
% str_bj  = sprintf('Modelo BJ (K = %.4f)', val_bj_1001/opt.StepAmplitude);
% str_fir  = sprintf('Modelo FIR (K = %.4f)', val_fir_1001/opt.StepAmplitude);
% plot(t,step_h(1:Tsim+1),t,step_mdlarx_1001,t,step_mdlarmax_1001,t,step_mdloe_1001,t,step_mdlbj_1001,t,step_mdlfir_1001);
% grid minor;xlabel('Tempo (s)');ylabel('Amplitude');
% legend(str_h,str_arx, str_armax, str_oe, str_bj,str_fir);
% title('Ganho estacion�rio dos modelos obtidos com PRBS');
% figure;
% ----------- item j ---------------

sim('lista3_item_j');

z2_prbs_1001_rapido = iddata(y2_prbs_1001_rapido(1:601),u_prbs_1001_rapido(1:601),T);
z2_prbs_1001_rapido_valid = iddata(y2_prbs_1001_rapido(601:Tsim_e),u_prbs_1001_rapido(601:Tsim_e),T);

% Estimando os modelos com dados obtidos com PRBS (e com
% perturba��o na sa�da)
mdlarx_1001_rapido = arx(z2_prbs_1001_rapido,[na nb nk]);
mdlarmax_1001_rapido = armax(z2_prbs_1001_rapido,[na nb nc nk]);
mdloe_1001_rapido = oe(z2_prbs_1001_rapido,[nb nf nk]);
mdlbj_1001_rapido = bj(z2_prbs_1001_rapido,[nb nc nd nf nk]);
mdlfir_1001_rapido = impulseest(z2_prbs_1001_rapido,ts,nk);

% Obten��o da resposta ao degrau para os modelos obtidos duas entradas sem
% perturba��o na sa�da
[step_mdlarx_1001_rapido] = step(mdlarx_1001_rapido,Tsim,opt);
[step_mdlarmax_1001_rapido] = step(mdlarmax_1001_rapido,Tsim,opt);
[step_mdloe_1001_rapido] = step(mdloe_1001_rapido,Tsim,opt);
[step_mdlbj_1001_rapido] = step(mdlbj_1001_rapido,Tsim,opt);
[step_mdlfir_1001_rapido] = step(mdlfir_1001_rapido,Tsim,opt);

% t = 0:600;
% plot(t,step_h(1:length(t)),t,step_mdlarx_1001_rapido,t,step_mdlarmax_1001_rapido,t,step_mdloe_1001_rapido,t,step_mdlbj_1001_rapido,t,step_mdlfir_1001_rapido);
% grid minor; legend('Sa�da limpa','Modelo ARX','Modelo ARMAX','Modelo OE','Modelo BJ','Modelo FIR')
% title('Resposta ao degrau dos modelos identificados com PRBS')
% figure;
% Obtendo o ganho estacion�rio da respsota ao degrau dos modelos sem perturba��o
[val_arx_1001_rapido,~] = max(step_mdlarx_1001_rapido);
[val_armax_1001_rapido,~] = max(step_mdlarmax_1001_rapido);
[val_oe_1001_rapido,~] = max(step_mdloe_1001_rapido);
[val_bj_1001_rapido,~] = max(step_mdlbj_1001_rapido);
[val_fir_1001_rapido,~] = max(step_mdlfir_1001_rapido);


% Compara��o da sa�da com perturba��o (ao degrau) do processo com os modelos estimados com
% perturba��o e com PRBS r�pido
% t = 0:600;
% [c_pert_1001_rapido, fit_pert] = compare(z2_degrau_275,mdlarx_1001_rapido,mdlarmax_1001_rapido,mdloe_1001_rapido,mdlbj_1001_rapido,mdlfir_1001_rapido);
% str_arx = sprintf('ARX: %.2f%%',fit_pert{1});
% str_armax = sprintf('ARMAX: %.2f%%',fit_pert{2});
% str_oe = sprintf('OE: %.2f%%',fit_pert{3});
% str_bj = sprintf('BJ: %.2f%%',fit_pert{4});
% str_fir = sprintf('FIR: %.2f%%',fit_pert{5});
% plot(t,z2_degrau_275.OutputData,t,c_pert_1001_rapido{1}.OutputData,t,c_pert_1001_rapido{2}.OutputData,t,c_pert_1001_rapido{3}.OutputData,t,c_pert_1001_rapido{4}.OutputData,t,c_pert_1001_rapido{5}.OutputData);
% legend('Sa�da do processo',str_arx,str_armax,str_oe,str_bj,str_fir); grid minor;
% title('Valida��o dos modelos estimados com PRBS (T_{b} = 4T) usando um degrau como entrada');xlabel('Tempo (s)');ylabel('Amplitude')

% ----------- item k ---------------

% Obten��o do ganho estacion�rio para
% a resposta ao degrau dos modelos obtidos com perturba��o

str_h  = sprintf('Resposta limpa (K = %.4f)', val_h/opt.StepAmplitude);
str_arx  = sprintf('Modelo ARX (K = %.4f)', val_arx_1001/opt.StepAmplitude);
str_armax  = sprintf('Modelo ARMAX (K = %.4f)', val_armax_1001/opt.StepAmplitude);
str_oe  = sprintf('Model  o OE (K = %.4f)', val_oe_1001/opt.StepAmplitude);
str_bj  = sprintf('Modelo BJ (K = %.4f)', val_bj_1001/opt.StepAmplitude);
str_fir  = sprintf('Modelo FIR (K = %.4f)', val_fir_1001/opt.StepAmplitude);
subplot(2,1,1);plot(t,step_h(1:Tsim+1),t,step_mdlarx_1001,t,step_mdlarmax_1001,t,step_mdloe_1001,t,step_mdlbj_1001,t,step_mdlfir_1001);
grid minor;xlabel('Tempo (s)');ylabel('Amplitude');
legend(str_h,str_arx, str_armax, str_oe, str_bj,str_fir);
title('Ganho estacion�rio dos modelos obtidos com PRBS lento T_{b} = 20T');
%figure;

% Obten��o do ganho estacion�rio para
% a resposta ao degrau dos modelos obtidos com perturba��o

str_h  = sprintf('Resposta limpa (K = %.4f)', val_h/opt.StepAmplitude);
str_arx  = sprintf('Modelo ARX (K = %.4f)', val_arx_1001_rapido/opt.StepAmplitude);
str_armax  = sprintf('Modelo ARMAX (K = %.4f)', val_armax_1001_rapido/opt.StepAmplitude);
str_oe  = sprintf('Model  o OE (K = %.4f)', val_oe_1001_rapido/opt.StepAmplitude);
str_bj  = sprintf('Modelo BJ (K = %.4f)', val_bj_1001_rapido/opt.StepAmplitude);
str_fir  = sprintf('Modelo FIR (K = %.4f)', val_fir_1001_rapido/opt.StepAmplitude);
subplot(2,1,2);plot(t,step_h(1:Tsim+1),t,step_mdlarx_1001_rapido,t,step_mdlarmax_1001_rapido,t,step_mdloe_1001_rapido,t,step_mdlbj_1001_rapido,t,step_mdlfir_1001_rapido);
grid minor;xlabel('Tempo (s)');ylabel('Amplitude');
legend(str_h,str_arx, str_armax, str_oe, str_bj,str_fir);
title('Ganho estacion�rio dos modelos obtidos com PRBS r�pido T_{b} = 4T');