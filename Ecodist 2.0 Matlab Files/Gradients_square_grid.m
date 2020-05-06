function [Theta_star]= ...
    Gradients_square_grid(z1,a,S)
% Calculating gradients at the square grid to get the Grasselli parameters
%  Input: 
%	z1 	sheared surface, a matrix
%	a 	grid constant 
%	S 	shear direction, x-direction would be [1 0 0]
%  Output:
%	Theta_star	matrix with theta^ast entries

% ========== get dimensions and initialize vectors =======================
[m,n]=size(z1);
Theta_star=zeros(m,n); %\theta^star, Grasselli


% ======== calculate theta^ast for all 4 shear directions
for ii=2:m-1
    for jj=2:n-1
        u=[a,0, z1(ii,jj)-z1(ii,jj+1)]; %forward deviation
        v=[0,a, z1(ii,jj)-z1(ii+1,jj)];
        normalvector=cross(u,v);
        normalvector=normalvector/norm(normalvector);
        theta=acos(normalvector(3));
        if theta==0
            Theta_star(ii,jj)=0;
        else 
            alpha=acos((normalvector(1)*S(1)+normalvector(2)*S(2))/norm(normalvector(1:2)));
            Theta_star(ii,jj)=-360/(2*pi)*atan(-tan(theta).*cos(alpha));
        end
    end
end

end

