function [F] = Force_normal(Aper, h,E,a)
%Calculates the normal elastic force of a rock
% surface with aperture. A negative aperture value
% corresponds to a deformation and creates an elastic
% force.
% Input:
%	Aper 	aperture field: matrix with entries in m 
%	h 		height of rock sample in m 
%	E 		E-modulus in Pa
%	a 		grid constant in m 
% Output:
%	F 		Force due to elastic deformation  

F=-sum(Aper(Aper<0)*E*(a)^2/h);

end

