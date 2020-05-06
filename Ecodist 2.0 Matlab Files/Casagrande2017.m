function [tau_peak,tau_res,z1_new]=Casagrande2017(z1,cohesion,sigma_n,phi_b,phi,a)
%Algorithm of Casagrande 2017 is used to calculate shear strength data.
% Input: 
%	z1			height matrix with entries in m 
%	cohesion	in Pa
%	sigma_n		normal stress in Pa
%	phi_b 		basic friction in degree
%	phi 		friction of rock in degree
%	a			grid constant in m 
% Output:
%	tau_peak	peak shear stress in Pa
%	tau_res		residual shear stress in Pa
%	z1_new		new geometry


[w,l]=size(z1);
w0=w*a;
l0=l*a;
F_n=sigma_n*w0*l0;

% ======= calculate apparent dip angles =================================
[Th_star]=Gradients_square_grid(z1,a,[1 0 0]);


% ========= run Casagrande Algorithm =====================================
[z1_new,F_slide]=Casagrande_Iteration(z1,Th_star,F_n,a,phi_b,phi,cohesion);


% ============ calculation of results ====================================
% stress_n0=F_n/(w0*l0); % normal stress acting on sample
F_peak=F_slide(end);
tau_peak=F_peak/(w0*l0); % peak shear stress
[m,n]=size(z1);
Ncf=m*n-length(find(z1_new==z1));
F_res=F_peak-cohesion*(a)^2*Ncf; % residual shear stress
tau_res=F_res/(w0*l0);



end

