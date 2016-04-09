% ------------- Item a-------------- %
H = tf(2,[10 1],'InputDelay',3);
Hd = c2d(H,1);
G_pert_2 = tf(2, [50 15 1]);
G_pert_2_discreta = c2d(G_pert_2,1);
G_pert_1 = tf(1, [5 1]);
G_pert_1_discreta = c2d(G_pert_1,1);
% % % % ------------- Item d-------------- %
% sim('lista1_questao4')
% subplot(2,2,1);plot(y_continuo_sem_perturbacao,'k');hold;plot(y_continuo_com_perturbacao_direta_alta,'k:');
% legend('Y sem perturba��o','Y com perturba��o direta '); grid minor;
% title('Y afetado por perturba��o direta com vari�ncia = 0.1');
% subplot(2,2,2);plot(y_continuo_sem_perturbacao,'k');hold;plot(y_continuo_com_perturbacao_1_alta,'k:');
% legend('Y sem perturba��o','Y com perturba��o com filtro de ordem 1'); grid minor;
% title('Y afetado por perturba��o com filtro de ordem 1 e vari�ncia = 0.1');
% subplot(2,2,3);plot(y_continuo_sem_perturbacao,'k');hold;plot(y_continuo_com_perturbacao_2_alta,'k:');
% legend('Y sem perturba��o','Y com perturba��o com filtro de ordem 2'); grid minor;
% title('Y afetado por perturba��o com filtro de ordem 2 e vari�ncia = 0.1');
% figure;
% subplot(2,2,1);plot(y_continuo_sem_perturbacao,'k');hold;plot(y_continuo_com_perturbacao_direta_baixa,'k:');
% legend('Y sem perturba��o','Y com perturba��o direta '); grid minor;
% title('Y afetado por perturba��o direta com vari�ncia = 0.001');
% subplot(2,2,2);plot(y_continuo_sem_perturbacao,'k');hold;plot(y_continuo_com_perturbacao_1_baixa,'k:');
% legend('Y sem perturba��o','Y com perturba��o com filtro de ordem 1'); grid minor;
% title('Y afetado por perturba��o com filtro de ordem 1 e vari�ncia = 0.001');
% subplot(2,2,3);plot(y_continuo_sem_perturbacao,'k');hold;plot(y_continuo_com_perturbacao_2_baixa,'k:');
% legend('Y sem perturba��o','Y com perturba��o com filtro de ordem 2'); grid minor;
% title('Y afetado por perturba��o com filtro de ordem 2 e vari�ncia = 0.001');

%------------- Item e-------------- %
% plot(y_continuo_sem_perturbacao,'k');hold;plot(y_continuo_com_perturbacao_v1_v2_baixa,'k:');
% legend('Y sem perturba��o','Y com perturba��es v_{1} e v_{2} baixas '); grid minor;
% title('Y afetado por duas perturba��es simult�neas e por um ru�do de medi��o');
% figure;
% plot(y_continuo_sem_perturbacao,'k');hold;plot(y_continuo_com_perturbacao_v1_v2_alta,'k:');
% legend('Y sem perturba��o','Y com perturba��es v_{1} e v_{2} altas '); grid minor;
% title('Y afetado por duas perturba��es simult�neas e por um ru�do de medi��o');

%------------- Item f-------------- %
% sim('lista1_questao6')
% t = 0:length(y_deg)-1;
% delta_y = max(y_deg_baixa) - min(y_deg_baixa);
% delta_x = max(u_entrada) - min(u_entrada);
% % O c�digo a seguir estima os par�metros para o sistema afetado por uma
% % perturba��o de baixa amplitude com base da resposta ao degrau
% y2_baixa = delta_y*0.853;
% y1_baixa = delta_y*0.353;
% f2_baixa = max(y_deg_baixa) - y2_baixa;
% f1_baixa = max(y_deg_baixa) - y1_baixa;
% f_baixa = f1_baixa/f2_baixa;
% % Encontrando o tempo mais pr�ximo dos valores de y1 e y2
% [~,index_y1_baixa] = min(abs(y_deg_baixa-y1_baixa));
% [~,index_y2_baixa] = min(abs(y_deg_baixa-y2_baixa));
% t1_baixa = t(index_y1_baixa);
% t2_baixa = t(index_y2_baixa);
% tau_baixa = 0.675*(t2_baixa - t1_baixa);
% theta_baixa = 1.294*t1_baixa - 0.294*t2_baixa;
% k = delta_y/delta_x;
% % Gerando o modelo com base nos valores estimados para perturba��o de 
% H_est_baixa = tf(k,[tau_baixa 1],'InputDelay',theta_baixa);
% % Calculando o tempo de acomoda��o, considerando ts o tempo para que a
% % resposta alcence 99% de delta_y
% y1_baixa_acomodacao = delta_y*0.99;
% [~,index_y1_baixa_acomodacao] = min(abs(y_deg_baixa-y1_baixa_acomodacao));
% ts = t(index_y1_baixa_acomodacao); % ts = 46 segundos.
% 
% % O c�digo a seguir estima os par�metros para o sistema afetado por uma
% % perturba��o de alta amplitude com base da resposta ao degrau
% y2_alta = delta_y*0.853;
% y1_alta = delta_y*0.353;
% f2_alta = max(y_deg_alta) - y2_alta;
% f1_alta = max(y_deg_alta) - y1_alta;
% f_alta = f1_alta/f2_alta;
% % Encontrando o tempo mais pr�ximo dos valores de y1 e y2
% [~,index_y1_alta] = min(abs(y_deg_alta-y1_alta));
% [~,index_y2_alta] = min(abs(y_deg_alta-y2_alta));
% t1_alta = t(index_y1_alta);
% t2_alta = t(index_y2_alta);
% tau_alta = 0.675*(t2_alta - t1_alta);
% theta_alta = 1.294*t1_alta - 0.294*t2_alta;
% k = delta_y/delta_x;
% % Gerando o modelo com base nos valores estimados para perturba��o de 
% H_est_alta = tf(k,[tau_alta 1],'InputDelay',theta_alta);
% sim('lista1_questao6_comparacao')
% plot(t,y_deg,'k',t,y_est_baixa,'k:',t,y_est_alta,'k--');
% legend('Processo sem perturba��o', 'Modelo estimando com baixa perturba��o', 'Modelo estimando com alta perturba��o'); grid minor

% %------------- Item g-------------- %
% sim('lista1_questao7')
% t = 0:length(pulso_entrada)-1;
% plot(t,y_pulso,'k',t,y_pulso_baixa,'k:',t,y_pulso_alta,'k--');
% legend('Resposta ao impulso do processo livre de perturba��o','Resposta ao impulso do processo com baixa perturba��o','Resposta ao impulso do processo com alta perturba��o'); grid minor;

% %------------- Item h-------------- %
T = 1; % Tempo de amostragem
sim('lista1_questao7')
sim('lista1_questao8')
t = 0:length(degrau_entrada)-1;
t_conv = 1:length(y_pulso)+length(y_degrau)-1;
y_conv = conv(y_pulso*T,degrau_entrada);
y_conv_baixa = conv(y_pulso_baixa*T,degrau_entrada);
y_conv_alta = conv(y_pulso_alta*T,degrau_entrada);
% plot(t,y_pulso_baixa,'k',t,y_pulso_alta,'k:'); grid minor;
% legend('Resposta ao degrau com baixa perturba��o','Resposta ao degrau com altaperturba��o');
% figure;
% plot(t,y_degrau_baixa,'k',t,y_degrau_alta,'k:'); grid minor;
% legend('Resposta ao degrau com baixa perturba��o','Resposta ao degrau com altaperturba��o');
% figure;
plot(t_conv,y_conv,'k',t_conv,y_conv_baixa,'k:',t_conv,y_conv_alta,'k--'); grid minor;
legend('Convolu��o com o pulso sem perturba��o','Convolu��o com o pulso de baixa perturba��o','Convolu��o com o pulso de alta perturba��o');
figure;
plot(t,y_degrau,'k',t_conv,y_conv,'k:'); grid minor;
legend('Resposta ao degrau do processo sem eprturba��o', 'Resposta da convolu��o do degram com a resposta ao pulso sem perturba��o')