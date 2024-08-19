function out = get_tau_iso_neq(xi_neq, be)
be_bar = be .* det(be)^(-1.0/3.0);
proj_P = get_sym_idn_4d() - (1.0/3.0) .* cross_otimes_2d_to_4d(eye(3), eye(3));
tau_bar_neq = get_tau_bar_neq(xi_neq, be_bar);
out = contract(proj_P, tau_bar_neq);
end