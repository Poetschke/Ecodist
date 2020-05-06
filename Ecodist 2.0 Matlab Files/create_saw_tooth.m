function M = create_saw_tooth(l,w,alpha1,alpha2,h,a)
%Creates a saw tooth surface 
% Input:
%	l		length of surface in m 
% 	w		width of surface in m 
%	h 		height of teeth in m 
%	alpha1	left slope angle in degree
%	alpha2	right slope angle in degree
%	a 		grid constant in m 
% Output:
%	M 		surface matrix 




M=zeros(round(w/a),round(l/a));

l_t=h/tan(alpha1*2*pi/360)+h/tan(alpha2*2*pi/360); % length of one tooth
n_t=floor(l/l_t); % number of teeth in profile

l_start=round((l-l_t*n_t)/2/a); % start position of first tooth in pixels

% create teeth
for i=1:n_t
    % left slope
    for j=1:round(h/tan(alpha1*2*pi/360)/a)
        l_start=l_start+1;
        M(:,l_start)=j*a*tan(alpha1*2*pi/360);
        
    end
    
    % right slope
    for k=round(h/tan(alpha2*2*pi/360)/a):-1:1
        l_start=l_start+1;
        M(:,l_start)=k*a*tan(alpha2*2*pi/360);
        
    end
        
end



end

