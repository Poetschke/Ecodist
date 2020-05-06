function tau = Xia2014(sigma_n, sigma_t,phi_b,A_0,theta_ast, C)
% Calculation of peak shear strength according to formula by Xia 2014
% Input:
% 	sigma_n 	normal stress in Pa  
%	sigma_t 	tensile strength in Pa  
% 	phi_b 		basic friction of material in degree 
% 	A_0 		Grasselli parameter active surface part
%	theta_ast 	Grasselli parameter max dip angle in degree
%	C 			Grasselli parameter fit coefficient
% Output: 
% 	tau 		peak shear strength in Pa


tau=sigma_n* tand(phi_b + 4*A_0*theta_ast/(C+1)*(1+exp(-1/(9*A_0)*...
    theta_ast*sigma_n/((C+1)*sigma_t))));

end

