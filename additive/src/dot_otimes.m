% refer to eqn. 2.10 of Liu, Guan, Zhao & Luo 2024 preprint
function out = dot_otimes(Ma, Mb)
[Va, Da] = eig(Ma);
[Vb, Db] = eig(Mb);
Na = Va(:,1);
Nb = Vb(:,1);
out = 0.5 .* cross_otimes_2d_to_4d(kron(Na, Nb'), kron(Na, Nb') + kron(Nb, Na'));
end