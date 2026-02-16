% Iterative solution for the recursive least squares
function [x_k_1, P_k_1] = recursive_wls(x_k, P_k, z_k_1, H_k_1, C_new)
    S_k_1 = H_k_1*P_k*H_k_1' + C_new;   % Covariance of the residuals
    W_k_1 = P_k*H_k_1'*S_k_1^-1;        % Update gain
    x_k_1 = x_k + W_k_1*(z_k_1 - H_k_1*x_k);
    P_k_1 = (eye(size(P_k)) - W_k_1*H_k_1)*P_k;
end