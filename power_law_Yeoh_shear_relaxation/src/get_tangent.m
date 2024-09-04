function out = get_tangent(xi, be1, be2, be3, beta1, beta2)
out = eye(3);
[dev_tau_1, dev_tau_2, dev_tau_3] = get_dev_tau_a(xi, be1, be2, be3);
D_b = get_D_b(xi, be1, be2, be3);
T_ab = get_T_ab(xi, be1, be2, be3);
T_bar_ab = get_T_bar_ab(xi, be1, be2, be3);
dev_tau = [dev_tau_1, dev_tau_2, dev_tau_3];
out = out + beta1 .* (dev_tau * dev_tau') * T_bar_ab + beta2 .* T_bar_ab;
% for ii = 1:3
%     for jj = 1:3
%         out(ii,jj) = out(ii,jj) + beta1 * dev_tau(ii) * D_b(jj) + beta2 * T_bar_ab(ii,jj);
%     end
% end
end