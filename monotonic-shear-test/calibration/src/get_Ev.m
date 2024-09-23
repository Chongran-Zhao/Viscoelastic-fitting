function out = get_Ev(mu, eta, E_old, E_new, dt)
out = exp(-mu*dt/eta) .* Ev_old + 0.5 * mu / eta * dt .* ( exp(-mu*dt/eta_d) .* E_old + E_new );
end