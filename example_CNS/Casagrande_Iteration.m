function [z,F_slide] = Casagrande_Iteration(z,Th,F_n,a,phi_b,phi,c)
%Calculation of shear forces according to Casagrande 2017 algorithm.
% Input:
%	z		height matrix 
%	F_n		normal force 
%	phi_b	basic friction in degree  
%	Th		Thet^ast matrix in degree  
%	a		grid constant in m
% Output:
%	z		new geometry
%	F_slide sliding force 	


% ========== initialisation =============================================
[m,n]=size(z);  %dimensions of the matrix
% starting values
f_shear=0;
f_slide=0;
i=0;
beta=max(Th(:))-0.1;

F_shear_map=zeros(size(z));
F_slide_map=zeros(size(z));

% =========== continue to destroy surface until sliding occurs ==========
while f_shear<=f_slide
	i=i+1; % count of iteration
		
	if beta>=89-phi_b

		contr=find(Th>=beta); % find contributing facets
		contr(contr>m*n-m)=[]; % facets at right edge cant be sheared off
		Ncf=length(contr);  % number of contributing facets


		for j=1:Ncf
			z(contr(j)+m)=z(contr(j)+m)-a*(sind(beta)-sind(beta-0.1)); 
		end

		F_shear(i)=0;
		F_slide(i)=0;

	else
		contr=find(Th>=beta); % find contributing facets
		contr(contr>m*n-m)=[]; % facets at right edge cant be sheared off
		Ncf=length(contr);  % number of contributing facets
		F_loc=F_n/Ncf;  % local force acting on one facet

		F_slide_map(contr)=F_loc*tand(phi_b+Th(contr));

		F_shear_map(contr)=(a)^2*(c+F_loc/((a)^2)*tand(phi));
		F_slide(i)=sum(F_slide_map(:));
		F_shear(i)=sum(F_shear_map(:));

		% new geometry of the contributing facets. the z-value of the neighbour
		% facet will be reduced by a value decreasing the dip by approx 0.1°
		Ncf_sheared_off=length(find(F_slide_map>F_shear_map));

		for j=1:Ncf_sheared_off
			z(contr(j)+m)=z(contr(j)+m)-a*(sind(beta)-sind(beta-0.1)); 
		end

	end

	% recalculate the apparent dip angles
	Th=Gradients_square_grid(z,a,[1 0 0]);

	% set new values of shearing and sliding force
	f_shear=F_shear(i);
	f_slide=F_slide(i);
	beta=max(Th(:))-0.1;

	F_shear_map=zeros(size(z));
	F_slide_map=zeros(size(z));

end

end

