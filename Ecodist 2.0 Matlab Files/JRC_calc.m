function [JRC] = JRC_calc(z,a)
%Calculation of joint roughness coefficient (JRC) for a given surface
% using Z2-value: JRC=32.69+2.98*log10(Z2) 
% Input:
%	z 		height matrix in m 
%	a 		grid constant
% Output:
%	JRC 	joint roughness coefficient

[m,n]=size(z);
JRC_i=zeros(m,0);
Z2=zeros(m,0);

% all profile traces are analyzed
for i=1:m
    Z2(i)=sqrt(1/(n*a^2)*sum((z(i,2:end)-z(i,1:end-1)).^2));
    % to avoid JRC<0 for very smooth surfaces
    if Z2(i)<=0.102 %=10^(-32.69/32.98)
        JRC_i(i)=0;
    else
        JRC_i(i)=32.69+32.98*log10(Z2(i)); 
    end
    
end

% average of all profile traces
JRC=mean(JRC_i,'omitnan');

end

