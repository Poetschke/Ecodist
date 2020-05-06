function [delta,sigma_n,tau,dil,e]=BB1985(L,JRC0,JCS0,sigma_n_Input,phi_r,phi_b,delta_u_s,u_s_max,K_n)
%BB1985 calculates shear test curves according to Barton, Bandis, 1985. 
% Input: 
%	L				length of sample in shear direction 
%	JRC0			JRC of this lab scale sample 
%	JCS0			JCS of lab scale sample 
%	sigma_n_Input	normal stress
% 	phi_r			residual friction 
%	phi_b			basic friction 
%	delta_u_s		displacement increment 
%	u_s_max			maximum shear displacement 
%	K_n 			normal stiffness
% Output: 
%	delta			displacement vector
% 	tau				shear stress vector
%   dil				dilation vector 
%	e				hydraulic aperture vector (not used)

% peak shear displacement
delta_p=L/500*(JRC0/L)^0.33;

sigma_n_0=sigma_n_Input; % sigma n at beginning

% initialize variables
delta=0:delta_u_s:u_s_max;
tau=zeros(size(delta));
JRC_mob=zeros(size(delta));
dil=zeros(size(delta));
e=zeros(size(delta));
sigma_n=zeros(size(delta));

sigma_n(1)=sigma_n_0;

% calculation for shear displacement step by step
for i=1:length(delta)
    if i>1
        sigma_n(i)=sigma_n_0+K_n*dil(i-1);
    end
    % roughness influence
    RUFF=JRC0*log10(JCS0/sigma_n(i));
    
    A=delta(i)/delta_p; % ratio of displacement to peak shear displacement
    B=lookuptable(A,phi_r,RUFF); % calculate parameter B using a table
    JRC_mob(i)=B*JRC0; % mobilized JRC
    
    % shear stress
    tau(i)=sigma_n(i)*tand(phi_b+JRC_mob(i)*log10(JCS0/sigma_n(i))); 
    
    if i>1
        % dilatation
        i_mob=0.5*JRC_mob(i)*log10(JCS0/sigma_n(i));
        dil(i)=dil(i-1)+delta_u_s*tand(i_mob);
        % hydraulic aperture (not used, may contain bugs)
        E_mech=dil(i)*1e6; % in µm
		%e(i)=E_mech^2/JRC_mob(i)^2.5/1e6; %calculation µm, result in m
        e(i)=E_mech; % ??? not clear
    end
    
end


function B=lookuptable(A,phi_r,RUFF)
%Table from Barton, Bandis 1985

switch true
    case (0<=A)&&(A<=0.2)
        B=-phi_r/RUFF+0.75*phi_r/RUFF*(A/0.2);
    case (0.2<A)&&(A<=0.3)
        B=-0.25*phi_r/RUFF+0.25*phi_r/RUFF*((A-0.2)/0.1);
    case (0.3<A)&&(A<=0.45)
        B=0.5*(A-0.3)/0.15;
    case (0.45<A)&&(A<=0.6)
        B=0.5+0.25*(A-0.45)/0.15;
    case (0.6<A)&&(A<=0.8)
        B=0.75+0.15*(A-0.6)/0.2;    
    case (0.8<A)&&(A<=1)
        B=0.9+0.1*(A-0.8)/0.2;    
    case (1<A)&&(A<=1.5)
        B=1-0.1*(A-1)/0.5;  
    case (1.5<A)&&(A<=2)
        B=0.9-0.05*(A-1.5)/0.5; 
    case (2<A)&&(A<=3)
        B=0.85-0.1*(A-2)/1;   
    case (3<A)&&(A<=4)
        B=0.75-0.05*(A-3)/1; 
    case (4<A)&&(A<=6)
        B=0.7-0.1*(A-4)/2;   
    case (6<A)&&(A<=8)
        B=0.6-0.05*(A-6)/2; 
    case (8<A)&&(A<=10)
        B=0.55-0.05*(A-8)/2;   
    case (10<A)&&(A<=20)
        B=0.5-0.1*(A-10)/10;
    case (20<A)&&(A<=100)
        B=0.4-0.4*(A-20)/80; 
    otherwise
        B=0;
       
end

end


end

