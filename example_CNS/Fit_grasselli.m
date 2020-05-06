function [C,th_max,A0,R2] = Fit_grasselli(alpha,grasselli)
% Fit a Grasselli curve.
% Input: 
%	alpha 		theta-ast matrix 
%	grasselli 	datapoints which should be fitted
% Output: 
% 	A0  		Grasselli parameter active surface part
%	th_max  	Grasselli parameter max dip angle in degree
%	C 			Grasselli parameter fit coefficient
%	R2			fitting degree

% ============ alpha is used to find maximum theta_star ================
alpha(isnan(alpha))=[];
alpha=sort(alpha,'descend');
th_max=alpha(1); %Theta_max, da alpha sortiert

% ======= if th_max=0 (smooth surface) the result doesn't matter ==========
if th_max==0
    C=1;
    th_max=0;
    A0=1;
    R2=1;

else 
	% ============= A_0 is first entry of grasselli ========================
	A0=grasselli(1); 

	% ============= initialize vector with theta_ast
	xx1=0:length(grasselli)-1; %\Theta^\ast

	% ============== set start value for C and stepwidth for search ========
	C=0.0; %initial value 
	step=0.01; %step-length for search

	% ===== increase C until the residuum between grasselli-curve and the
	% fitted function increases again ======================================
	while 1
		gr_analyt=A0*((th_max-xx1)/th_max).^C; %Grasselli-curve analytical
		Resid=norm(gr_analyt-grasselli);    %residuum
		gr_analyt2=A0*((th_max-xx1)/th_max).^(C+step);
		Resid2=norm(gr_analyt2-grasselli);
		if Resid2>Resid
			break
		end
		C=C+step;
	end

	% ========= calculate different statistical parameters ===================
	mittelwert=sum(grasselli)/length(grasselli);   %mean value
	abw_mw=grasselli-mittelwert;     % difference vector for mean value
	abw_fit=grasselli-gr_analyt2;    % difference vector of fit
	R2=1-(dot(abw_fit,abw_fit))/(dot(abw_mw,abw_mw));% coeff of determination

end

end

