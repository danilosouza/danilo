% ------------- Item a-------------- %
%H = tf(2,[10 1],'InputDelay',3);
%Hd = c2d(H,1);

% % % ------------- Item d-------------- %
% subplot(2,2,1);plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_direta_alta);
% legend('Y sem perturba��o','Y com perturba��o direta '); grid minor;
% title('Y afetado por perturba��o direta com vari�ncia = 0.1');
% subplot(2,2,2);plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_1_alta);
% legend('Y sem perturba��o','Y com perturba��o com filtro de ordem 1'); grid minor;
% title('Y afetado por perturba��o com filtro de ordem 1 e vari�ncia = 0.1');
% subplot(2,2,3);plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_2_alta);
% legend('Y sem perturba��o','Y com perturba��o com filtro de ordem 2'); grid minor;
% title('Y afetado por perturba��o com filtro de ordem 2 e vari�ncia = 0.1');
% figure;
% subplot(2,2,1);plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_direta_baixa);
% legend('Y sem perturba��o','Y com perturba��o direta '); grid minor;
% title('Y afetado por perturba��o direta com vari�ncia = 0.001');
% subplot(2,2,2);plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_1_baixa);
% legend('Y sem perturba��o','Y com perturba��o com filtro de ordem 1'); grid minor;
% title('Y afetado por perturba��o com filtro de ordem 1 e vari�ncia = 0.001');
% subplot(2,2,3);plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_2_baixa);
% legend('Y sem perturba��o','Y com perturba��o com filtro de ordem 2'); grid minor;
% title('Y afetado por perturba��o com filtro de ordem 2 e vari�ncia = 0.001');

%------------- Item e-------------- %
plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_v1_v2_baixa);
legend('Y sem perturba��o','Y com perturba��es v_{1} e v_{2} baixas '); grid minor;
title('Y afetado por duas perturba��es simult�neas e por um ru�do de medi��o');
figure;
plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_v1_v2_alta);
legend('Y sem perturba��o','Y com perturba��es v_{1} e v_{2} altas '); grid minor;
title('Y afetado por duas perturba��es simult�neas e por um ru�do de medi��o');