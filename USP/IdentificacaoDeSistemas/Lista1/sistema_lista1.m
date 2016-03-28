% ------------- Item a-------------- %
%H = tf(2,[10 1],'InputDelay',3);
%Hd = c2d(H,1);

% % ------------- Item d-------------- %
% plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_direta_baixa,'k');
% plot(y_continuo_com_perturbacao_1_baixa);plot(y_continuo_com_perturbacao_2_baixa);
% legend('Y sem perturbação','Y com perturbação direta ','Y com perturbação 1','Y com perturbação 2'); grid minor;
% title('Y afetado por perturbações geradas com variância = 0.001');
% figure;
% plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_direta_alta,'k');
% plot(y_continuo_com_perturbacao_1_alta);plot(y_continuo_com_perturbacao_2_alta);
% legend('Y sem perturbação','Y com perturbação direta ','Y com perturbação 1','Y com perturbação 2'); grid minor;
% title('Y afetado por perturbações geradas com variância = 0.1');

% ------------- Item e-------------- %
plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_v1_v2);
legend('Y sem perturbação','Y com perturbações V_{1} e V_{2} '); grid minor;
title('Y afetado por duas perturbações simultâneas não-correlacionadas com variância = exp(-6)');