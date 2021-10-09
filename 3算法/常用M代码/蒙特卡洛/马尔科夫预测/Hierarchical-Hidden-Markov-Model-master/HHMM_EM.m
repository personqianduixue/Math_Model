function [PI_new, A_new, B_new P] = HHMM_EM(q, seq, A, PI, B, alph, Palt)

%% Parameter Estimation

% % Expectation
% [alpha beta ] = expectationAlphaBeta(A, PI, q, B, seq);
% fprintf('Alpha-Beta-Estimation done\n');
% [eta_in eta_out ] = expectationEta(A, PI, q, alpha, beta, seq);
% fprintf('Eta-Estimation done\n');
% [xi chi gamma_in gamma_out ] = expectationXiChi(A, PI, q, eta_in, eta_out, alpha, beta, seq);
% fprintf('Gamma-Estimation done\n');
% 
% % Maximization
% [PI_new A_new B_new] = estimation(PI, q, xi, chi, gamma_in, gamma_out, seq);
% fprintf('Parameter-Estimation done\n\n');

    %% Parameter Estimation Log

    % Expectation
    A = log(A);
    B = log(B);
    PI = log(PI);
    
    [alpha beta ] = expectationAlphaBetaLog(A, PI, q, B, seq);
    P = sum(exp(alpha(1,length(seq),2,:,1,1)));
%     fprintf('Alpha-Beta-Estimation done: %d, previous P %d\n', P, Palt);
    
    [eta_in eta_out ] = expectationEtaLog(A, PI, q, alpha, beta, seq);
%     fprintf('Eta-Estimation done\n');
    
    [xi chi gamma_in gamma_out ] = expectationXiChiLog(A, PI, q, eta_in, eta_out, alpha, beta, seq);
%     fprintf('Gamma-Estimation done\n');

    % Maximization
    [PI_new A_new B_new] = estimationLog(q, xi, chi, gamma_in, gamma_out, seq, B, alph);
%     fprintf('Parameter-Estimation done\n');
end
