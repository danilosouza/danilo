% ------------- Item a-------------- %
%H = tf(2,[10 1],'InputDelay',3);
%Hd = c2d(H,1);

% % ------------- Item d-------------- %
% plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_direta_baixa,'k');
% plot(y_continuo_com_perturbacao_1_baixa);plot(y_continuo_com_perturbacao_2_baixa);
% legend('Y sem perturba��o','Y com perturba��o direta ','Y com perturba��o 1','Y com perturba��o 2'); grid minor;
% title('Y afetado por perturba��es geradas com vari�ncia = 0.001');
% figure;
% plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_direta_alta,'k');
% plot(y_continuo_com_perturbacao_1_alta);plot(y_continuo_com_perturbacao_2_alta);
% legend('Y sem perturba��o','Y com perturba��o direta ','Y com perturba��o 1','Y com perturba��o 2'); grid minor;
% title('Y afetado por perturba��es geradas com vari�ncia = 0.1');

% ------------- Item e-------------- %
plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_v1_v2);
legend('Y sem perturba��o','Y com perturba��es V_{1} e V_{2} '); grid minor;
title('Y afetado por duas perturba��es simult�neas n�o-correlacionadas com vari�ncia = exp(-6)');