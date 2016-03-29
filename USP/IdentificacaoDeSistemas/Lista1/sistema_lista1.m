% ------------- Item a-------------- %
%H = tf(2,[10 1],'InputDelay',3);
%Hd = c2d(H,1);

% % % ------------- Item d-------------- %
% subplot(2,2,1);plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_direta_alta);
% legend('Y sem perturbação','Y com perturbação direta '); grid minor;
% title('Y afetado por perturbação direta com variância = 0.1');
% subplot(2,2,2);plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_1_alta);
% legend('Y sem perturbação','Y com perturbação com filtro de ordem 1'); grid minor;
% title('Y afetado por perturbação com filtro de ordem 1 e variância = 0.1');
% subplot(2,2,3);plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_2_alta);
% legend('Y sem perturbação','Y com perturbação com filtro de ordem 2'); grid minor;
% title('Y afetado por perturbação com filtro de ordem 2 e variância = 0.1');
% figure;
% subplot(2,2,1);plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_direta_baixa);
% legend('Y sem perturbação','Y com perturbação direta '); grid minor;
% title('Y afetado por perturbação direta com variância = 0.001');
% subplot(2,2,2);plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_1_baixa);
% legend('Y sem perturbação','Y com perturbação com filtro de ordem 1'); grid minor;
% title('Y afetado por perturbação com filtro de ordem 1 e variância = 0.001');
% subplot(2,2,3);plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_2_baixa);
% legend('Y sem perturbação','Y com perturbação com filtro de ordem 2'); grid minor;
% title('Y afetado por perturbação com filtro de ordem 2 e variância = 0.001');

%------------- Item e-------------- %
plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_v1_v2_baixa);
legend('Y sem perturbação','Y com perturbações v_{1} e v_{2} baixas '); grid minor;
title('Y afetado por duas perturbações simultâneas e por um ruído de medição');
figure;
plot(y_continuo_sem_perturbacao);hold;plot(y_continuo_com_perturbacao_v1_v2_alta);
legend('Y sem perturbação','Y com perturbações v_{1} e v_{2} altas '); grid minor;
title('Y afetado por duas perturbações simultâneas e por um ruído de medição');